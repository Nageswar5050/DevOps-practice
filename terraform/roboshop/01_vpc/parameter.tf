resource "aws_ssm_parameter" "vpc_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc_id"
  value = module.roboshop_vpc.main_vpc_id
}

resource "aws_ssm_parameter" "main_igw_id" {
  type = "String"
  name = "/${var.project_name}/${var.environment}/igw_id"
  value = module.roboshop_vpc.main_igw_id
}

resource "aws_ssm_parameter" "frontend_subnet_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/frontend_subnet_id"
  value = module.roboshop_vpc.main_frontend_subnet_id
}

resource "aws_ssm_parameter" "backend_subnet_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/backend_subnet_id"
  value = module.roboshop_vpc.main_backend_subnet_id
}

resource "aws_ssm_parameter" "database_subnet_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/database_subnet_id"
  value = module.roboshop_vpc.main_database_subnet_id
}

resource "aws_ssm_parameter" "database_subnet_rt_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/database_rt_id"
  value = module.roboshop_vpc.main_database_subnet_rt_id
}

resource "aws_ssm_parameter" "backend_subnet_rt_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/backend_rt_id"
  value = module.roboshop_vpc.main_backend_subnet_rt_id
}