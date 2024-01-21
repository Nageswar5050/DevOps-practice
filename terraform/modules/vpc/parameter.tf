resource "aws_ssm_parameter" "main_vpc_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc_id"
  value = aws_vpc.main_vpc.id
}

resource "aws_ssm_parameter" "main_igw" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/igw_id"
  value = aws_internet_gateway.main_igw.id
}

resource "aws_ssm_parameter" "frontend_subnet_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/frontend_subnet_id"
  value = local.frontend_subnet_id
}

resource "aws_ssm_parameter" "backend_subnet_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/backend_subnet_id"
  value = local.backend_subnet_id
}

resource "aws_ssm_parameter" "database_subnet_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/database_subnet_id"
  value = local.database_subnet_id
}