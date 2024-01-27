resource "aws_ssm_parameter" "main_sg_id" {
  type = "StringList"
  name = "/${var.project_name}/${var.environment}/sg_ids"
  value = join(",",module.roboshop_sg.sg_id[*])
}