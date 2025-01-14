resource "aws_lb" "app-lb" {
  name               = "app-lb-session5"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [for subnet in var.app-subnets-pub : subnet]


  tags = {
    Environment = "production"
    Name        = "App Load Balancer"
  }
}

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.app-lb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_listener.https.arn
#   }
# }


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


################ HTTPS/443 ##############
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = data.aws_acm_certificate.cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}
data "aws_acm_certificate" "cert" {
  domain = "tesraa.com"
}