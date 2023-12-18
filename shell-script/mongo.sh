#!/bin/bash

ID=$(id -u)
TIME=$(date +%H:%M:%S)
DATE=$(date +F)
TIMESTAMP=$(date +%F-%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
NC="\e[0m"

echo "script started executing at $DATE-$TIME"

if [ $? -ne 0 ]
then
    echo -e "$Y Please login as root $NC"
fi

VALIDATE(){
    if [ $? -ne 0 ]
    then
        echo -e "$1..... $R FAILED $NC"
        exit 1
    else
        echo -e "$1..... $G SUCCESS $NC"
    fi
}

timedatectl set-timezone Asia/Kolkata

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOGFILE

VALIDATE "Created mongo repo"

dnf install mongodb-org -y &>>LOGFILE

VALIDATE "Install mongoDB"

systemctl enable mongod&>>LOGFILE

VALIDATE "Enable mongoDB"

systemctl start mongod&>>LOGFILE

VALIDATE "Start mongoDB"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>LOGFILE

VALIDATE "Allowed all to mongoDB config file"

systemctl restart mongod &>>LOGFILE

VALIDATE "Restarted mongoDB service"