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

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> $LOGFILE

VALIDATE "downloading app data"

cd /app &>> $LOGFILE

unzip -o /tmp/cart.zip &>> $LOGFILE

VALIDATE "unzipping application data"

npm install &>> $LOGFILE

VALIDATE "npm installation"

cp /home/centos/shell-script/cart.service /etc/systemd/system/  &>> $LOGFILE

VALIDATE "copying cart.service file"

sed -i 's/<CATALOGUE-SERVER-IP>/catalogue.challa.cloud/' /etc/systemd/system/cart.service &>> $LOGFILE
sed -i 's/<REDIS-SERVER-IP>/redis.challa.cloud/' /etc/systemd/system/cart.service &>> $LOGFILE

VALIDATE "adding catalogue and redis ip in service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE "reloading daemon"

systemctl enable cart &>> $LOGFILE

VALIDATE "enabling cart"

systemctl start cart &>> $LOGFILE

VALIDATE "starting cart"