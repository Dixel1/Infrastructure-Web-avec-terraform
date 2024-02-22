resource "aws_autoscaling_group" "asg-schaffnerkelian" {
  name              = "asgschaffnerkelian"
  max_size          = 2
  min_size          = 1
  desired_capacity  = 2
  target_group_arns = [aws_lb_target_group.tg-schaffnerkelian.arn]
  launch_template {
    id      = aws_launch_template.launchtemplate-schaffnerkelian.id
    version = "$Latest"
  }
  availability_zones = ["eu-west-1a"]
}

