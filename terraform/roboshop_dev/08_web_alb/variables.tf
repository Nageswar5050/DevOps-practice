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

variable "web_alb_tags" {
  type    = map(any)
  default = {}
}

variable "zone_id" {
  type    = string
  default = "Z10424741G2H2DBEZUCEI"
}

variable "domain_name" {
  type    = string
  default = "challa.cloud"
}