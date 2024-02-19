resource "aws_security_group" "main" {
  vpc_id = data.aws_ssm_parameter.vpc_id
  name = "Allow all"
  description = "Allowing all"
}

resource "" "name" {
  
}