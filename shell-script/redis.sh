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

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>LOGFILE

VALIDATE "Adding Redis"

dnf module enable redis:remi-6.2 -y &>>LOGFILE

VALIDATE "Enable Redis"

dnf install redis -y &>>LOGFILE

VALIDATE "Install Redis"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>LOGFILE

VALIDATE "Allowed all to mongoDB config file"

systemctl enable redis &>>LOGFILE

VALIDATE "Enabled redis service"

systemctl start redis &>>LOGFILE

VALIDATE "Starting redis service"