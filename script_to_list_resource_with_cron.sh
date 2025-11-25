#!/bin/bash


######
#Author:Abisheak
#Date: 25-11-2025



######script to list the available resources

AWS="/usr/local/bin/aws"
JQ="/usr/bin/jq"
LOGFILE="/mnt/c/Users/abish/abi/output.txt"
{


set -x

#S3
echo "---LIst of s3 ----"
$AWS s3 ls
echo "---LIst of ec2 ----"
#ec2
$AWS ec2 describe-instances | $JQ '.Reservations[].Instances[] | "\(.InstanceId) \(.State.Name)"'
echo "---LIst of iam users ----"
# Iams users
$AWS iam list-users | $JQ '.Users[] | "\(.UserName) \(.UserId)"'
echo "---LIst of Lambda Functions ----"
# Lambda Functions
$AWS lambda list-functions
} > "$LOGFILE" 2>&1

################
#  Crontab -e
#  6 9 * * * /mnt/c/Users/abish/abi/script.sh
