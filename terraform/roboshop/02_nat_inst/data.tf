data "aws_ami" "main_nat_inst_ami" {
    owners = ["137112412989"]
    most_recent = true
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

data "aws_ssm_parameter" "sg_id" {
  name = "/${var.project_name}/${var.environment}/sg_ids"
}

data "aws_ssm_parameter" "main_backend_route_table_id" {
  name  = "/${var.project_name}/${var.environment}/backend_rt_id"
}

data "aws_ssm_parameter" "main_database_route_table_id" {
  name  = "/${var.project_name}/${var.environment}/database_rt_id"
}