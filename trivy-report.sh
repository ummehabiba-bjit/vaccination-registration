#!/bin/bash

# Read the Trivy report from the file
trivy_report=$(cat trivy_scan.log)

# Define your Slack webhook URL
slack_webhook_url="https://hooks.slack.com/services/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"

# Create a JSON payload for the Slack message
payload="{\"text\":\"Trivy Vulnerability Report:\\n$trivy_report\"}"

# Send the message to Slack
curl -X POST -H 'Content-type: application/json' --data "$payload" "$slack_webhook_url"
