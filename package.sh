#!/bin/bash

ID=$(id -u)
os=$(grep "^ID=" /etc/os-release | cut -d '=' -f2 | tr -d '"')

if [ $ID -ne 0 ]
then
    echo "To run this script you need proper privileges"
    exit
fi

echo "Select one of the package you want to install from below:"
echo "1-Ansible"
echo "2-Docker"
echo "3-Python3"
echo "4-Kubernetes"
echo "5-Terraform"
echo "6-Jenkins"

read package 

if [ "$os" = "ubuntu" ]
then
    case $package in
        1) echo "Installing Ansible"
            sudo apt update -y
            sudo apt install software-properties-common -y
            sudo add-apt-repository --yes --update ppa:ansible/ansible -y
            sudo apt install ansible -y;;
        2) ecacho "Installing Docker"
            sudo apt-get update -y
            sudo apt-get install ca-certificates curl -y
            sudo install -m 0755 -d /etc/apt/keyrings
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
            sudo chmod a+r /etc/apt/keyrings/docker.asc
            echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get update
            sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
            sudo usermod -aG docker ubuntu
            exit;;
        6) echo "Installing jenkins"
            sudo apt update -y
            sudo apt install fontconfig openjdk-17-jre -y 
            sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
                https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
            echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
            sudo apt-get update -y
            sudo apt-get install jenkins -y
            sudo systemctl enable jenkins
            sudo systemctl start jenkins
            echo "Use the below password to open jenkins WEB-UI;"  
            cat /var/lib/jenkins/secrets/initialAdminPassword #This is the Dummy Password
    esac
           
else
    case $package in
        1) echo "Installing Ansible"
            sudo yum update -y
            sudo yum install ansible -y;;
        2) echo "Installing Docker"
            sudo yum install -y yum-utils
            sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
            sudo usermod -aG docker ec2-user
            exit;;
        6) echo "Installing Jenkins"
            sudo wget -O /etc/yum.repos.d/jenkins.repo \
                https://pkg.jenkins.io/redhat-stable/jenkins.repo
            sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
            sudo yum upgrade -y
            # Add required dependencies for the jenkins package
            sudo yum install fontconfig java-17-openjdk -y
            sudo yum install jenkins -y
            sudo systemctl enable jenkins
            sudo systemctl start jenkins
            echo "Use the below password to open jenkins WEB-UI;" 
            cat /var/lib/jenkins/secrets/initialAdminPassword #This is the Dummy Password
    esac
fi