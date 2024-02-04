resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"
  type  = "String"
  value = module.roboshop_vpc.main_vpc_id
}

resource "aws_ssm_parameter" "main_igw_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
  type = "String"
  value = module.roboshop_vpc.main_igw
}

resource "aws_ssm_parameter" "frontend_subnet_id" {
  name  = "/${var.project_name}/${var.environment}/frontend_subnet_id"
  type  = "String"
  value = module.roboshop_vpc.main_frontend_subnet_id
}

resource "aws_ssm_parameter" "backend_subnet_id" {
  name  = "/${var.project_name}/${var.environment}/backend_subnet_id"
  type  = "String"
  value = module.roboshop_vpc.main_backend_subnet_id
}

resource "aws_ssm_parameter" "database_subnet_id" {
  name  = "/${var.project_name}/${var.environment}/database_subnet_id"
  type  = "String"
  value = module.roboshop_vpc.main_database_subnet_id
}