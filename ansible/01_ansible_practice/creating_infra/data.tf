data "aws_ami" "ami_id" {
  owners      = ["973714476881"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice"]
  }
}


