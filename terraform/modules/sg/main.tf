resource "aws_security_group" "main_sg" {
  count       = length("${var.instance_names}")
  vpc_id      = data.aws_vpc.main_vpc_id.id
  name        = var.instance_names[count.index]
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  description = "${var.sg_description}-${var.instance_names[count.index]}"
  tags = merge(
    "${var.common_tags}",
    "${var.sg_tags}",
    {
      Name = "${var.project_name}-${var.environment}-${var.instance_names[count.index]}-sg"
    }
  )
}