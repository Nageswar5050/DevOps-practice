data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "frontend_subnet_id" {
  name = "/${var.project_name}/${var.environment}/frontend_subnet_id"
}

data "aws_ssm_parameter" "backend_subnet_id" {
  name = "/${var.project_name}/${var.environment}/backend_subnet_id"
}

data "aws_ssm_parameter" "databse_subnet_id" {
  name = "/${var.project_name}/${var.environment}/database_subnet_id"
}

data "aws_ssm_parameter" "nat_instance_network_id" {
  name = "/${var.project_name}/${var.environment}/nat_instance_network_id"
}

data "aws_ssm_parameter" "frontend_rt_id" {
  name = "/${var.project_name}/${var.environment}/frontend_rt_id"
}

data "aws_ssm_parameter" "backend_rt_id" {
  name = "/${var.project_name}/${var.environment}/backend_rt_id"
}

data "aws_ssm_parameter" "database_rt_id" {
  name = "/${var.project_name}/${var.environment}/databse_rt_id"
}

data "aws_ssm_parameter" "igw_id" {
  name = "/${var.project_name}/${var.environment}/igw_id"
}