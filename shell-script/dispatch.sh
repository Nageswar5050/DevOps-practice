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

dnf install golang -y $LOGFILE

VALIDATE "Installing golang"

id roboshop

if [ $? -ne 0 ]
then
        adduser roboshop
else
        echo -e "User already added ...$Y SKIPPING$NC"
fi

mkdir -p /app &>> $LOGFILE

VALIDATE "created /app directory"

curl -L -o /tmp/dispatch.zip https://roboshop-builds.s3.amazonaws.com/dispatch.zip &>> $LOGFILE

VALIDATE "downloading app data"

cd /app &>> $LOGFILE

unzip -o /tmp/dispatch.zip &>> $LOGFILE

VALIDATE "unzipping application data"

go mod init dispatch &>> $LOGFILE
go get &>> $LOGFILE
go build &>> $LOGFILE

VALIDATE "npm installation"

cp /home/centos/shell-script/dispatch.service /etc/systemd/system/  &>> $LOGFILE

systemctl daemon-reload &>> $LOGFILE

VALIDATE "reloading daemon"

systemctl enable dispatch &>> $LOGFILE

VALIDATE "enabling dispatch"

systemctl start dispatch &>> $LOGFILE

VALIDATE "starting dispatch"