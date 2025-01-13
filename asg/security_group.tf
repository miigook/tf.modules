resource "aws_security_group" "lb-sg" {
  name        = "allow_http_sg"
  description = "Allow http inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.app.vpc_id
  tags = {
    Name = "lb-sg-app"

  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow-https" {
  security_group_id = aws_security_group.lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


############## Security Group for Launch Template #########

resource "aws_security_group" "lt-sg" {
  name        = "allow_http-lt"
  description = "Allow http inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.app.vpc_id

  tags = {
    Name = "lt-sg-app"

  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_lt" {
  security_group_id = aws_security_group.lt-sg.id
  referenced_security_group_id = aws_security_group.lb-sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-lt" {
  security_group_id = aws_security_group.lt-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
