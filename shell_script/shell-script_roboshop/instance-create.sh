#!/bin/bash

AMI="ami-03265a0778a880afb"
SG_ID="sg-0a23b50af6d4b1ba4"
NAME=("web" "mongo" "user" "catalogue" "cart" "shipping" "payment" "dispatch" "mysql" "redis" "rabbitmq")
DOMAIN="challa.cloud"
ZONEID=Z10424741G2H2DBEZUCEI


for i in ${NAME[@]}
do
        IPADDRESS=(aws ec2 run-instances --image-id $AMI --instance-type t2.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'instances[0].PrivateIpAddress' --output text)

        aws route53 change-resource-record-sets --hosted-zone-id $ZONEID --change-batch ' 
         {
        "Comment": "Creating a record set for cognito endpoint"
        ,"Changes": [{
        "Action"              : "CREATE"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$i'.'$DOMAIN'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IPADDRESS'"
            }]
        }
        }]
    }'
  
done