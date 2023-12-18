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

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> $LOGFILE

VALIDATE "Downloading RabbitMQ"

dnf install rabbitmq-server -y &>> $LOGFILE

VALIDATE "Installing rabbitMQ"

systemctl enable rabbitmq &>> $LOGFILE

VALIDATE "enabling RabbitMQ"

systemctl start rabbitmq &>> $LOGFILE

VALIDATE "starting RabbitMQ"

rabbitmqctl add_user roboshop roboshop123 &>> $LOGFILE

VALIDATE "Adding user in RabbitMQ"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $LOGFILE