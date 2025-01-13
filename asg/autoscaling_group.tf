resource "aws_autoscaling_group" "app-asg" {
  name                      = "asg-session6"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  vpc_zone_identifier = [for subnet in data.output.priv_subnets_ids : subnet] # [aws_subnet.priv[0].id]

  launch_template {
    id      = aws_launch_template.apache-lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "app-asg" {
  autoscaling_group_name = aws_autoscaling_group.app-asg.id
  lb_target_group_arn    = aws_lb_target_group.web-tg.arn
}