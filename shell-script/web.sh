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

dnf install nginx -y &>> $LOGFILE

VALIDATE "Installing Nginx"

systemctl enable nginx &>> $LOGFILE

VALIDATE "enabling nginx"

systemctl start nginx &>> $LOGFILE

VALIDATE "starting nginx"

rm -rf /usr/share/nginx/html/* &>> $LOGFILE

VALIDATE "Removing existing html"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE

VALIDATE "Downloading new http content"

unzip -o /tmp/web.zip &>> $LOGFILE

VALIDATE "Unzipping html content"

cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE

VALIDATE "Copying nginx reverse proxy data"

systemctl restart nginx &>> $LOGFILE