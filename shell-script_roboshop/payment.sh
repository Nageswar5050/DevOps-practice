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

timedatectl set-timezone Asia/Kolkata  &>> $LOGFILE

dnf install python36 gcc python3-devel -y  &>> $LOGFILE

VALIDATE "Installing Python" 

id roboshop

if [ $? -ne 0 ]
then
        adduser roboshop
else
        echo -e "User already added ...$Y SKIPPING$NC"
fi

mkdir -p /app &>> $LOGFILE

VALIDATE "created /app directory"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>> $LOGFILE

VALIDATE "downloading app data"

cd /app &>> $LOGFILE

unzip -o /tmp/payment.zip &>> $LOGFILE

VALIDATE "unzipping application data"

pip3.6 install -r requirements.txt &>> $LOGFILE

VALIDATE "installation packages"

cp /home/centos/shell-script/payment.service /etc/systemd/system/  &>> $LOGFILE

VALIDATE "copying payment.service file"

sed -i 's/<CART-SERVER-IPADDRESS>/cart.challa.cloud/' /etc/systemd/system/payment.service &>> $LOGFILE
sed -i 's/<USER-SERVER-IPADDRESS>/user.challa.cloud/' /etc/systemd/system/payment.service &>> $LOGFILE
sed -i 's/<RABBITMQ-SERVER-IPADDRESS>/rabbitmq.challa.cloud/' /etc/systemd/system/payment.service &>> $LOGFILE

VALIDATE "adding mongodb ip in service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE "reloading daemon"

systemctl enable payment &>> $LOGFILE

VALIDATE "enabling payment"

systemctl start payment &>> $LOGFILE

VALIDATE "starting payment"