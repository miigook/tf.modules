resource "aws_lb_target_group" "web-tg" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.app-vpc

  tags = {
    Name = "Target Group"
  }
}




