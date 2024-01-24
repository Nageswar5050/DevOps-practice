variable "instance_names" {
  type = list
}

variable "sg_description" {
  type = string
}

variable "common_tags" {
  type = map
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "sg_tags" {
  type    = map
  default = {}
}