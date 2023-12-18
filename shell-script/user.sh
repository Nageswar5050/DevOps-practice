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

timedatectl set-timezone Asia/Kolkata

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

mkdir -p /app &>> $LOGFILE

VALIDATE "created /app directory"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE

VALIDATE "downloading app data"

cd /app &>> $LOGFILE

unzip -o /tmp/user.zip &>> $LOGFILE

VALIDATE "unzipping application data"

npm install &>> $LOGFILE

VALIDATE "npm installation"

cp /home/centos/shell-script/user.service /etc/systemd/system/  &>> $LOGFILE

VALIDATE "copying user.service file"

sed -i 's/<MONGODB-SERVER-IPADDRESS>/mongo.challa.cloud/' /etc/systemd/system/user.service &>> $LOGFILE
sed -i 's/<REDIS-SERVER-IP>/redis.challa.cloud/' /etc/systemd/system/user.service &>> $LOGFILE

VALIDATE "adding mongodb and redis ip in service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE "reloading daemon"

systemctl enable user &>> $LOGFILE

VALIDATE "enabling user"

systemctl start user &>> $LOGFILE

VALIDATE "starting user"

cp /home/centos/shell-script/user.repo /etc/yum.repos.d/user.repo &>> $LOGFILE

VALIDATE "copying user data"

dnf install mongodb-org-shell -y &>> $LOGFILE

VALIDATE "installimg mongoshell"

mongo --host mongo.challa.cloud </app/schema/user.js &>> $LOGFILE