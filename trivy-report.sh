#!/bin/bash


# Set your S3 bucket name and Slack webhook URL
S3_BUCKET_NAME=vaccination-pipeline-artifactstore
SLACK_WEBHOOK_URL=$(aws ssm get-parameter --name slack-webhook-url --with-decryption --query "Parameter.Value" --output text)

# Specify the file name you want to retrieve
FILE_NAME="trivy_scan.log"

# Download the file from S3
aws s3 cp trivy_scan.log s3://vaccination-pipeline-artifactstore/reports/Trivy/trivy_scan.$CODEBUILD_BUILD_ID.log

# Read the file content
LOG_CONTENT=$(cat ./${FILE_NAME})

# Send the file content to Slack
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$LOG_CONTENT\"}" ${SLACK_WEBHOOK_URL}




# # Read the Trivy report from the file
# trivy_report=$(cat trivy_scan.log)

# # Retrieve the Slack webhook URL from AWS Systems Manager Parameter Store
# SLACK_WEBHOOK=$(aws ssm get-parameter --name slack-webhook-url --with-decryption --query "Parameter.Value" --output text)

# # # Create a JSON payload for the Slack message
# # payload=
# # {
# #   "text": "Trivy Vulnerability Report:\\n$trivy_report"
# # }
# # # "{\"text\":\"Trivy Vulnerability Report:\\n$trivy_report\"}"

# # # Send the message to Slack
# # curl -X POST -H 'Content-type: application/json' --data "$payload" "$SLACK_WEBHOOK"
# curl -X POST -H 'Content-type: application/json' --data '{"text": "Trivy Vulnerability Report:\n$(cat trivy_scan.log)"}' $SLACK_WEBHOOK
