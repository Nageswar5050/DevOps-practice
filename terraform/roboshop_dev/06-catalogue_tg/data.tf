data "aws_ssm_parameter" "roboshop_vpc" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

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

data "aws_ssm_parameter" "sg_id" {
  name = "/${var.project_name}/${var.environment}/sg_ids"
}

data "aws_ssm_parameter" "frontend_subnet_id" {
  name = "/${var.project_name}/${var.environment}/frontend_subnet_id"
}

data "aws_ssm_parameter" "database_subnet_id" {
  name = "/${var.project_name}/${var.environment}/database_subnet_id"
}

data "aws_ssm_parameter" "backend_subnet_id" {
  name = "/${var.project_name}/${var.environment}/backend_subnet_id"
}

data "aws_ssm_parameter" "aws_lb_listener_arn" {
  name = "/${var.project_name}/${var.environment}/aws_lb_listener_arn"
}