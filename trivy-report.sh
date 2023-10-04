#!/bin/bash

# Read the Trivy report from the file
trivy_report=$(cat trivy_scan.log)

# Define your Slack webhook UR
SLACK_WEBHOOK= slack-webhook-url
# Create a JSON payload for the Slack message
payload="{\"text\":\"Trivy Vulnerability Report:\\n$trivy_report\"}"

# Send the message to Slack
curl -X POST -H 'Content-type: application/json' --data "$payload" "$SLACK_WEBHOOK"
