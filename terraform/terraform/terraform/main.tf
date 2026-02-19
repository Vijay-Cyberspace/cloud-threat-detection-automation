provider "aws" {
  region = "us-east-1"
}

resource "aws_guardduty_detector" "gd" {
  enable = true
}

resource "aws_iam_role" "lambda_role" {
  name = "threat_response_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_lambda_function" "threat_response" {
  function_name = "cloud-threat-response"
  role          = aws_iam_role.lambda_role.arn
  handler       = "threat_response.lambda_handler"
  runtime       = "python3.9"

  filename         = "../lambda_function.zip"
  source_code_hash = filebase64sha256("../lambda_function.zip")

  environment {
    variables = {
      VIRUSTOTAL_API_KEY = "replace_me"
      ABUSEIPDB_API_KEY  = "replace_me"
    }
  }
}

resource "aws_cloudwatch_event_rule" "guardduty_rule" {
  name        = "guardduty-findings-rule"
  description = "Triggers Lambda on GuardDuty findings"

  event_pattern = jsonencode({
    source = ["aws.guardduty"]
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.guardduty_rule.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.threat_response.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.threat_response.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.guardduty_rule.arn
}
