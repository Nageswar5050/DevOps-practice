resource "aws_ssm_parameter" "sg_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/sg_id"
  value = local.sg_id
}