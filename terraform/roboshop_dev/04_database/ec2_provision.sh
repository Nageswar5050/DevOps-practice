#!/bin/bash
sudo yum install ansible -y
git clone https://github.com/Nageswar5050/DevOps-practice.git
cd DevOps-practice/ansible/ansible_roles_roboshop
ansible-playbook -e component=mongo main.yml
ansible-playbook -e component=redis main.yml
ansible-playbook -e component=rabbitmq main.yml
ansible-playbook -e component=mysql main.yml
ansible-playbook -e component=catalogue main.yml
ansible-playbook -e component=user main.yml
ansible-playbook -e component=cart main.yml
ansible-playbook -e component=shipping main.yml
ansible-playbook -e component=payment main.yml
ansible-playbook -e component=web main.yml
