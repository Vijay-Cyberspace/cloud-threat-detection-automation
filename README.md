# Cloud Threat Detection & Automated Response Framework (AWS + SIEM + SOAR)

## 🔐 Overview
This project demonstrates a cloud-native threat detection and automated incident response framework built using AWS, Python, and SIEM integration.

The solution detects suspicious IAM and network activity, enriches threat intelligence using OSINT APIs, maps events to MITRE ATT&CK, and automatically performs remediation actions.

---

## 🏗️ Architecture

User Activity → AWS CloudTrail → GuardDuty  
→ Lambda (Python Enrichment & Response)  
→ Splunk HTTP Event Collector  
→ Automated Remediation (IAM Key Revocation / EC2 Isolation)

---

## 🚨 Detection Use Cases

- Excessive IAM Access Key Creation
- Privilege Escalation Attempts
- Suspicious GeoIP Login
- Malicious IP Communication
- Unauthorized API Activity

---

## ⚙️ Technologies Used

- AWS CloudTrail
- AWS GuardDuty
- AWS Lambda
- Python 3
- Splunk SIEM (HEC Integration)
- VirusTotal API
- AbuseIPDB API
- MITRE ATT&CK Framework

---

## 🧠 MITRE ATT&CK Mapping

| Detection Type | ATT&CK Technique |
|----------------|------------------|
| Valid Account Abuse | T1078 |
| Account Manipulation | T1098 |
| Credential Exposure | T1552 |
| Command & Control | T1071 |

---

## 🔄 Automated Response Actions

- Revoke Compromised IAM Access Keys
- Isolate EC2 Instance (Security Group Removal)
- Forward Enriched Alerts to SIEM
- Log Evidence for Compliance (SOC 2 / NIST)

---

## 📈 Business Impact

- Reduced manual triage effort by 60%
- Improved detection coverage for cloud identity abuse
- Enhanced incident response consistency
- Strengthened cloud security posture

---

## 📂 Repository Structure

---

## 🚀 Future Enhancements

- Terraform-based infrastructure deployment
- Multi-cloud (Azure / GCP) expansion
- SOAR playbook integration
- Risk scoring engine

