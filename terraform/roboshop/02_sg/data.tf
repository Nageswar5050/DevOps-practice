data "aws_vpc" "main_vpc_id" {
  tags = {
    Terraform = "true"
  }
}