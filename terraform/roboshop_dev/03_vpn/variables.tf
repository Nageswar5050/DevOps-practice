variable "instance_type" {
  type    = string
  default = "t2.micro"
}

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

variable "zone_id" {
  type    = string
  default = "Z10424741G2H2DBEZUCEI"
}

variable "domain_name" {
  type    = string
  default = "challa.cloud"
}