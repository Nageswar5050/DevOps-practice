resource "aws_ssm_parameter" "aws_lb_listener_arn" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/aws_lb_listener_arn"
  value = aws_lb_listener.http.arn
}