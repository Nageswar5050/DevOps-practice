output "vpc_id" {
  value = data.aws_vpc.main_vpc_id
}

output "sg_id" {
  value = aws_security_group.main_sg[*].id
}