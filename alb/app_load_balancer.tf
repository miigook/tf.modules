resource "aws_lb" "app-lb" {
  name               = "app-lb-session5"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [for subnet in data.output.pub_subnets_ids : subnet]


  tags = {
    Environment = "production"
    Name        = "App Load Balancer"
  }
}
