resource "aws_ssm_parameter" "vpc_id" {
  type = "String"
  value = aws_vpc.main.id
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

resource "aws_ssm_parameter" "frontend_subnet_id" {
    type = "String"
  value = local.frontend_subnet_id
  name = "/${var.project_name}/${var.environment}/frontend_subnet_id"
}

resource "aws_ssm_parameter" "backend_subnet_id" {
    type = "String"
  value = local.backend_subnet_id
  name = "/${var.project_name}/${var.environment}/backend_subnet_id"
}

resource "aws_ssm_parameter" "database_subnet_id" {
    type = "String"
  value = local.database_subnet_id
  name = "/${var.project_name}/${var.environment}/database_subnet_id"
}

resource "aws_ssm_parameter" "nat_instance_network_id" {
    type = "String"
  value = aws_instance.nat_instance.primary_network_interface_id
  name = "/${var.project_name}/${var.environment}/nat_instance_network_id"
}

resource "aws_ssm_parameter" "frontend_rt_id" {
  type = "String"
  name = "/${var.project_name}/${var.environment}/frontend_rt_id"
  value = aws_route_table.frontend_rt.id
}

resource "aws_ssm_parameter" "backend_rt_id" {
  type = "String"
  name = "/${var.project_name}/${var.environment}/backend_rt_id"
  value = aws_route_table.backend_rt.id
}

resource "aws_ssm_parameter" "database_rt_id" {
  type = "String"
  name = "/${var.project_name}/${var.environment}/database_rt_id"
  value = aws_route_table.database_rt.id
}

resource "aws_ssm_parameter" "igw_id" {
  type = "String"
  name = "/${var.project_name}/${var.environment}/igw_id"
  value = aws_internet_gateway.main.id
}