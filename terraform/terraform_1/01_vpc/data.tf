data "aws_availability_zones" "az_list" {
  state = "available"
}

data "aws_ami" "nat_ami" {
  owners = ["301380864081"]
}