data "aws_ssm_parameter" "sg_id" {
  name = "/${var.project_name}/${var.environment}/sg_ids"
}

data "aws_ssm_parameter" "backend_subnet_id" {
  name = "/${var.project_name}/${var.environment}/backend_subnet_id"
}