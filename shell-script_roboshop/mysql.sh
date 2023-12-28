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

dnf module disable mysql -y &>> $LOGFILE

VALIDATE "Disabling MySQL"

cp -u /home/centos/shell-script/mysql.repo /etc/yum.repos.d/mysql.repo &>> $LOGFILE

VALIDATE "Copied Mysql repo"

dnf install mysql-community-server -y &>> $LOGFILE

VALIDATE "Installing MySQL 5.7"

systemctl enable mysqld &>> $LOGFILE

VALIDATE "Enabling MySQL"

systemctl start mysqld &>> $LOGFILE

VALIDATE "Starting MySQL"

mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOGFILE

VALIDATE "Changing MySQL root password"