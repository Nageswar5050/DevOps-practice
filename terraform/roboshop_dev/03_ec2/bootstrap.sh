#!/bin/bash

sudo yum install python3.11-devel python3.11-pip
pip3.11 install ansible boto3 botocore

ansible pull 