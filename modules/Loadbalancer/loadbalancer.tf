resource "aws_lb" "example_lb" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security-group.id]
  subnets            = [
    aws_subnet.public-subnet-1.id,  # us-east-1a
    aws_subnet.public-subnet-2.id   # us-east-1b
  ]
  enable_deletion_protection = false

  enable_http2 = true
  idle_timeout = 60

  tags = {
    Name = var.alb_name
  }
}

# Create the target group for EC2 instances
resource "aws_lb_target_group" "example_target_group" {
  name     = "example-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "instance"


  health_check {
    interval            = 30
    path                = "/"
    port                = "8000"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.target_name
  }
}

# Create a listener for the Application Load Balancer (HTTP listener on port 80)
resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.example_lb.arn
  port              = 80       # Listener on port 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.example_target_group.arn
  }

  tags = {
    Name = var.listenerName
  }
}


# Register EC2 instances with the target group
resource "aws_lb_target_group_attachment" "example_attachment_1" {
#   count               = 2
  target_group_arn    = aws_lb_target_group.example_target_group.arn
  target_id           = aws_instance.ec2-instance-1.id
  port                = 8000
}

resource "aws_lb_target_group_attachment" "example_attachment_2" {
#   count               = 2
  target_group_arn    = aws_lb_target_group.example_target_group.arn
  target_id           = aws_instance.ec2-instance-2.id
  port                = 8000
}