variable "common_tags" {
  type = map
  default = {
    Name = "Roboshop"
    Environment = "dev"
    Terraform = true
  }
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "frontend_subnet_cidr" {
  type = list
  default = ["10.0.1.0/24", "10.0.11.0/24"]
}

variable "backend_subnet_cidr" {
  type = list
  default = ["10.0.2.0/24", "10.0.22.0/24"]
}

variable "vpc_tags" {
  type = map
  default = {
    Name = "VPC"
  }
}

variable "frontend_subnet_tags" {
  type = map
  default = {
    Name = "frontend_subnet"
  }
}

variable "backend_subnet_tags" {
  type = map
  default = {
    Name = "backend_subnet"
  }
}

variable "database_subnet_tags" {
  type = map
  default = {
    Name = "database_subnet"
  }
}

variable "database_subnet_cidr" {
  type = list
  default = ["10.0.3.0/24", "10.0.33.0/24"]
}

variable "igw_tags" {
  type = map
  default = {
    Name = "IGW"
  }
}

variable "frontend_rt_tags" {
  type = map
  default = {
    Name = "frontend_rt"
  }
}

variable "backend_rt_tags" {
  type = map
  default = {
    Name = "backend_rt"
  }
}

variable "database_rt_tags" {
  type = map
  default = {
    Name = "database_rt"
  }
}

variable "project_name" {
  type = string
  default = "roboshop"
}

variable "environment" {
  type = string
  default = "dev"
}