#!/bib/bash

component=$1
environment=$2

sudo yum install python3.11-devel python3.11-pip -y
pip3.11 install ansible boto3 botocore

ansible-pull -U https://github.com/Nageswar5050/ansible_roles_tf.git -e component=$component -e env=$environment main.yml