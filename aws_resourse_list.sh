#!/bin/bash

# This script lists all AWS resources in the specified region using AWS CLI.
#1.Ec2
#2.S3
#3.Lambda
#4.DynamoDB
#5.RDS
#6.CloudFormation
#7.IAM Users
#8.VPCs


# usage: ./aws_resource_list.sh <region> <service-name>
# Example: ./aws_resource_list.sh us-east-1 ec2

#check if the correct number of arguments is provided

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <region> <service-name>"
    exit 1
fi

# check if aws cli is installed

if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it to use this script."
    exit 1
fi

# check if aws cli is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure it using 'aws configure'."
    exit 1
fi

#case statement to handle different services
case $2 in
    ec2)
        aws ec2 describe-instances --region $1
        ;;
    s3)
        aws s3 ls --region $1
        ;;
    lambda)
        aws lambda list-functions --region $1
        ;;
    dynamodb)
        aws dynamodb list-tables --region $1
        ;;
    rds)
        aws rds describe-db-instances --region $1
        ;;
    cloudformation)
        aws cloudformation describe-stacks --region $1
        ;;
    iam)
        aws iam list-users
        ;;
    vpc)
        aws ec2 describe-vpcs --region $1
        ;;
    *)
        echo "Unsupported service. Supported services are: ec2, s3, lambda, dynamodb, rds, cloudformation, iam, vpc."
        exit 1
        ;;
esac
