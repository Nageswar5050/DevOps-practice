variable "common_tags" {
  type = map(any)
  default = {
    Name      = "Roboshop"
    Terraform = "true"
  }
}

variable "project_name" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "sg_tags" {
  type    = map(any)
  default = {}
}

variable "instance_names" {
  type = list(any)
  default = [
    "mongo",     #0
    "mysql",     #1
    "redis",     #2
    "rabbitmq",  #3
    "catalogue", #4
    "user",      #5
    "cart",      #6
    "payment",   #7
    "shipping",  #8
    "dispatch",  #9
    "web",       #10
    "vpn",       #11
    "alb",       #12
  ]
}

variable "sg_description" {
  type    = string
  default = "Security group for"
}