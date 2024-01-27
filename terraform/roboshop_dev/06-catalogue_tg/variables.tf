variable "project_name" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  type = map(any)
  default = {
    Name      = "Roboshop"
    Terraform = "true"
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_names" {
  type = list(any)
  default = [
    "mongo",
    "mysql",
    "redis",
    "rabbitmq",
    "catalogue",
    "user",
    "cart",
    "payment",
    "shipping",
    "dispatch",
    "web",
    "vpn"
  ]
}

variable "tags" {
  default = {
    Component = "catalogue"
  }
}