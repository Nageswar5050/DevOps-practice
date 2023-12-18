#!/bin/bash

ID=$(id -u)
RID=$(id roboshop)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
NC="\e[0m"
TIMESTAMP=$(date +%F-%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script stareted executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){
    if [ $? -ne 0 ]
    then
        echo -e "$1 ... $R FAILED $NC"
        exit 1
    else
        echo -e "$1 ... $G SUCCESS $NC"
    fi
}

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $NC"
    exit 1
else
    echo -e "$Y You are root user$NC"
fi

dnf module disable nodejs -y &>> $LOGFILE

VALIDATE "disabling nodejs"

dnf module enable nodejs:18 -y &>> $LOGFILE

VALIDATE "enabling nodejs:18"

dnf install nodejs -y &>> $LOGFILE

VALIDATE "installing nodejs"

id roboshop

if [ $? -ne 0 ]
then
        adduser roboshop
else
        echo -e "User already added ...$Y SKIPPING$NC"
fi

timedatectl set-timezone Asia/Kolkata

mkdir -p /app &>> $LOGFILE

VALIDATE "created /app directory"

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE

VALIDATE "downloading app data"

cd /app &>> $LOGFILE

unzip -o /tmp/catalogue.zip &>> $LOGFILE

VALIDATE "unzipping application data"

npm install &>> $LOGFILE

VALIDATE "npm installation"

cp /home/centos/shell-script/catalogue.service /etc/systemd/system/  &>> $LOGFILE

VALIDATE "copying catalogue.service file"

sed -i 's/<MONGODB-SERVER-IPADDRESS>/mongo.challa.cloud/' /etc/systemd/system/catalogue.service &>> $LOGFILE

VALIDATE "adding mongodb ip in service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE "reloading daemon"

systemctl enable catalogue &>> $LOGFILE

VALIDATE "enabling catalogue"

systemctl start catalogue &>> $LOGFILE

VALIDATE "starting catalogue"

cp /home/centos/shell-script/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE "copying mongodb data"

dnf install mongodb-org-shell -y &>> $LOGFILE

VALIDATE "installimg mongoshell"

mongo --host mongo.challa.cloud </app/schema/catalogue.js &>> $LOGFILE