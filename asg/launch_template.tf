resource "aws_launch_template" "apache-lt" {
  name = "apache-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 8
    }
  }

  disable_api_stop        = false
  disable_api_termination = false

  image_id = "ami-01816d07b1128cd2d"

  instance_initiated_shutdown_behavior = "stop"

  instance_type = "t2.micro"

  key_name = "amin@macbook"

  monitoring {
    enabled = false
  }

  vpc_security_group_ids = [aws_security_group.lt-sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web_tesraacom"
    }
  }



  user_data = filebase64("${path.module}/user_data.sh")
}