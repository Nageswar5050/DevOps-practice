module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstation"

  instance_type          = "t2.micro"
  ami = "ami-0f3c7d07486cad139"
  vpc_security_group_ids = ["sg-0e159184a7bd00fd0"]
  subnet_id              = "subnet-0b61aa5fef733576b"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}