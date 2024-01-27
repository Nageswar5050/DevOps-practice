resource "aws_lb" "roboshop_alb" {
  name               = "${var.project_name}-${var.environment}-app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [split(",",data.aws_ssm_parameter.sg_id.value)[12]]
  subnets            = split(",",data.aws_ssm_parameter.backend_subnet_id.value)

  # enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = merge(
    var.common_tags,
    var.alb_tags
  )
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.roboshop_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, I am from application load balancer"
      status_code  = "200"
    }
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.domain_name

  records = [
    {
      name    = "*.app-${var.environment}"
      type    = "A"
      alias   = {
        name    = aws_lb.roboshop_alb.dns_name
        zone_id = aws_lb.roboshop_alb.zone_id
      }
    }
  ]
}