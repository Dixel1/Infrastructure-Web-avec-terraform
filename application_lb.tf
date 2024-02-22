# create an ALB on port 80
resource "aws_lb" "alb-schaffnerkelian" {
  name                       = "alb-schaffnerkelian"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sghttp-schaffnerkelian.id]
  subnets                    = ["subnet-0e3b5a73eb879dbe8", "subnet-03818601518f096d0"]
  enable_deletion_protection = false
  tags = {
    Name = "alb-schaffnerkelian"
  }
}

# create a listener on port 80 for load balancer
resource "aws_lb_listener" "listener-schaffnerkelian" {
  load_balancer_arn = aws_lb.alb-schaffnerkelian.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-schaffnerkelian.arn
  }
}

resource "aws_lb_target_group" "tg-schaffnerkelian" {
  name     = "tg-schaffnerkelian"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0049682c1b010a070"
}