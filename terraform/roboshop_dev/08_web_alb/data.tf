data "aws_ssm_parameter" "sg_id" {
  name = "/${var.project_name}/${var.environment}/sg_ids"
}

data "aws_ssm_parameter" "frontend_subnet_id" {
  name = "/${var.project_name}/${var.environment}/frontend_subnet_id"
}

data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/acm_certificate_arn"
}