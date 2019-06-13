#!/bin/sh
# AWS STS currently supports VPC endpoints in the US West (Oregon) Region only.
# export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)
# export CONTAINER_CREDENTIALS=$(curl -s http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI)
export AccessKeyId=$(curl -s http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI | jq '.AccessKeyId')
export SecretAccessKey=$(curl -s http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI | jq '.SecretAccessKey')
export Token=$(curl -s http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI | jq '.Token')