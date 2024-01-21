variable "ami_id" {
  type    = string
  default = "ami-0f3c7d07486cad139"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_names" {
  default = ["mongo", "mysql", "web"]
  type    = list
}