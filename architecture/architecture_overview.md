# Architecture Overview

User Activity
     ↓
AWS CloudTrail
     ↓
GuardDuty Findings
     ↓
Lambda (Python Enrichment & Response)
     ↓
Splunk SIEM (HEC)
     ↓
Automated Remediation (IAM Key Revocation / EC2 Isolation)
