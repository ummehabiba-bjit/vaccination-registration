#!/bin/bash

# Read the Trivy report from the file
trivy_report=$(cat trivy_scan.log)

# Retrieve the Slack webhook URL from AWS Systems Manager Parameter Store
SLACK_WEBHOOK=$(aws ssm get-parameter --name slack-webhook-url --with-decryption --query "Parameter.Value" --output text)

# # Create a JSON payload for the Slack message
# payload=
# {
#   "text": "Trivy Vulnerability Report:\\n$trivy_report"
# }
# # "{\"text\":\"Trivy Vulnerability Report:\\n$trivy_report\"}"

# # Send the message to Slack
# curl -X POST -H 'Content-type: application/json' --data "$payload" "$SLACK_WEBHOOK"
curl -X POST -H 'Content-type: application/json' --data '{"text": "Trivy Vulnerability Report:\n$(cat trivy_scan.log)"}' $SLACK_WEBHOOK
