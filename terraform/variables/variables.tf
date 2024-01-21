variable "ami_id" {
  type    = string
  default = "ami-0f3c7d07486cad139"
  sensitive = true # It we use this attribute when we use terraform plan or terraform apply it will display as sensitive, by defaukt this flag is set as false, NOTE: it will save as clear text in state file. 
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}