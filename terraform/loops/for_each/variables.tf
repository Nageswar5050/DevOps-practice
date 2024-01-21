variable "ami_id" {
  type    = string
  default = "ami-0f3c7d07486cad139"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_names" {
  type = map
  default = {
    mongo = "t2.micro"
    mysql =  "t2.micro"
    web = "t3.micro"
}
}