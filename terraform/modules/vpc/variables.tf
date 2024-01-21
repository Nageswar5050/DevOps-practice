variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "common_tags" {
  type = map(any)
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_tags" {
  type    = map(any)
  default = {}
}

variable "frontend_subnet_cidr" {
  type = list(any)
  validation {
    condition     = length(var.frontend_subnet_cidr) == 2
    error_message = "Please enter only 2 subnets, because module only supports for 2 available availablility zones"
  }
}

variable "database_subnet_cidr" {
  type = list(any)
  validation {
    condition     = length("${var.database_subnet_cidr}") == 2
    error_message = "Please enter only 2 subnets, because module only supports for 2 available availablility zones"
  }
}

variable "backend_subnet_cidr" {
  type = list(any)
  validation {
    condition     = length("${var.backend_subnet_cidr}") == 2
    error_message = "Please enter only 2 subnets, because module only supports for 2 available availablility zones"
  }
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