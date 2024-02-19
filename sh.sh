#!/bin/bash

#Use this script to run the containers in docker

echo "Enter the list of names using commas you want to assign for containers:"
read names

docker run -d -it --name $names ubuntu:latest
# echo "Enter the hostname of the device:"
# read HOST

IPADD=$(docker inspect $names | grep "IP" | sed -n 7p | awk -F'"' '{print $4}')

file="~/.ssh/id_ed25519"

if [ -f $file  ]
then
    echo "Key exists"
else
    ssh-keygen -t ed25519
fi

docker exec -it $names sh -c "usermod root -p root"
#docker exec -it $names sh -c "useradd $HOST -d /home/ubuntu/ -p ubuntu"
#docker exec -it $names sh -c "mkdir /home/ubuntu/.ssh/"
docker exec -it $names sh -c "apt update -y"
docker exec -it $names sh -c "apt install sudo"
docker exec -it $names sh -c "apt install ssh -y"
docker exec -it $names sh -c "service ssh start"
docker exec -it $names sh -c "sudo apt install python3 -y"
docker exec -it $names sh -c "sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config" #This is the Dummy Password
docker exec -it $names sh -c "sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config" #This is the Dummy Password
docker exec -it $names sh -c "sudo sed -i 's/#TCPKeepAlive yes/TCPKeepAlive no/' /etc/ssh/sshd_config"
docker exec -it $names sh -c "sudo sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 10/' /etc/ssh/sshd_config"
docker exec -it $names sh -c "sudo sed -i 's/#ClientAliveCountMax 3/ClientAliveCountMax 240/' /etc/ssh/sshd_config"
docker exec -it $names sh -c "service ssh restart"
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@$IPADD