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

dnf install maven -y

VALIDATE "Installing Maven"

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

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> $LOGFILE

VALIDATE "downloading app data"

cd /app &>> $LOGFILE &>> $LOGFILE

unzip -o /tmp/shipping.zip &>> $LOGFILE

VALIDATE "unzipping application data"

mvn clean package &>> $LOGFILE

VALIDATE "Installing application"

mv target/shipping-1.0.jar shipping.jar &>> $LOGFILE

sed -i 's/<CART-SERVER-IPADDRESS>/cart.challa.cloud/' /etc/systemd/system/shipping.service &>> $LOGFILE
sed -i 's/<MYSQL-SERVER-IPADDRESS>/mysql.challa.cloud/' /etc/systemd/system/shipping.service &>> $LOGFILE

VALIDATE "Adding cart and Mysql ip to shipping.service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE "reloading daemon"

systemctl enable shipping &>> $LOGFILE

VALIDATE "enabling shipping"

systemctl start shipping &>> $LOGFILE

VALIDATE "starting shipping"

dnf install mysql -y

VALIDATE "Installing MySQL to load data"

mysql -h mysql.challa.cloud -uroot -pRoboShop@1 < /app/schema/shipping.sql 

VALIDATE "Loaded schema"

systemctl restart shipping