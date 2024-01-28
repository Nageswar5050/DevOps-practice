resource "aws_lb" "roboshop_web_alb" {
  name               = "${var.project_name}-${var.environment}-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [split(",",data.aws_ssm_parameter.sg_id.value)[13]]
  subnets            = split(",",data.aws_ssm_parameter.frontend_subnet_id.value)
  tags = merge(
    var.common_tags,
    var.web_alb_tags
  )
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.roboshop_web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value


  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, I am from web application load balancer"
      status_code  = "200"
    }
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.domain_name

  records = [
    {
      name    = "web-${var.environment}"
      type    = "A"
      alias   = {
        name    = aws_lb.roboshop_web_alb.dns_name
        zone_id = aws_lb.roboshop_web_alb.zone_id
      }
    }
  ]
}