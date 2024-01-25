#!/bin/bash

component=$1
environment=$2

sudo yum install python3.11-devel pip3.11
pip3.11 install boto3 botocore ansible

ansible pull -U https://github.com/Nageswar5050/ansible_roles_tf.git -e component=$component -e env=$environment main.tf