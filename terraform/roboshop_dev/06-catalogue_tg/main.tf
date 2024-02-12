resource "aws_lb_target_group" "catalogue_tg" {
  name     = "${var.project_name}-${var.environment}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.roboshop_vpc.value
  deregistration_delay = 60
  health_check {
    path = "/health"
    port = 8080
    healthy_threshold = 2
    unhealthy_threshold = 3
    timeout = 5
    interval = 10
    matcher = "200-299"  # has to be HTTP 200 or fails
  }
}

module "roboshop_catalogue" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  iam_instance_profile = "Full_access_to_EC2_and_Route53"
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 4)]
  #iam_instance_profile = ""
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[4]}-ami"
  }
}

resource "null_resource" "catalogue_ami_null" {
  triggers = {
    instance_id = module.roboshop_catalogue.id
  }

  connection {
    host = module.roboshop_catalogue.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321" #This is the Dummy Password
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue dev"
     ]
  }
}

resource "aws_ec2_instance_state" "stop" {
  instance_id = module.roboshop_catalogue.id
  state       = "stopped"
  depends_on = [ null_resource.catalogue_ami_null ]
}

resource "aws_ami_from_instance" "catalogue_ami" {
  name               = "${local.name}-${var.tags.Component}-${local.current_time}"
  source_instance_id = module.roboshop_catalogue.id
  depends_on = [ aws_ec2_instance_state.stop ]
}

resource "null_resource" "terminate_instance" {
  triggers = {
    instance_id = module.roboshop_catalogue.id
  }

  connection {
    host = module.roboshop_catalogue.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321" #This is the Dummy Password
  }

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${module.roboshop_catalogue.id}"
  }

  depends_on = [ aws_ami_from_instance.catalogue_ami ]
}

resource "aws_launch_template" "catalogue_launch_template" {
  name = "${var.project_name}-${var.environment}"
  image_id = aws_ami_from_instance.catalogue_ami.id
  update_default_version = true
  instance_type = "t2.micro"
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 4)]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.name}-${var.tags.Component}"
    }
  }
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.name}-${var.tags.Component}"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  vpc_zone_identifier       = split(",", data.aws_ssm_parameter.backend_subnet_id.value)
  target_group_arns =  [ aws_lb_target_group.catalogue_tg.id ]

  launch_template {
    id      = aws_launch_template.catalogue_launch_template.id
    version = aws_launch_template.catalogue_launch_template.latest_version
  }
  tag {
    key                 = "Name"
    value               = "${local.name}-${var.tags.Component}"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = data.aws_ssm_parameter.aws_lb_listener_arn.value
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue_tg.arn
  }
    condition {
      host_header {
        values = ["${var.tags.Component}.app-${var.environment}.${var.domain_name}"]
    }
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name                   = "${local.name}-${var.tags.Component}"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 5.0
  }
}
