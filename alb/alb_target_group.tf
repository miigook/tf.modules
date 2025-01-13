resource "aws_lb_target_group" "web-tg" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.output.vpc_id

  tags = {
    Name = "Target Group"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}

