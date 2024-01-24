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

variable "vpc_tags" {
  type    = map(any)
  default = {}
}

variable "frontend_subnet_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "backend_subnet_cidr" {
  type    = list(any)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidr" {
  type    = list(any)
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "subnet_tags" {
  type    = map(any)
  default = {}
}

variable "eip_tags" {
  type    = map(any)
  default = {}
}

variable "ngw_tags" {
  type    = map(any)
  default = {}
}

variable "rt_tags" {
  type    = map(any)
  default = {}
}