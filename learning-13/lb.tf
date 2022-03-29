resource "aws_lb" "bookstore" {
  name               = var.LOAD_BALANCER["name"]
  internal           = false
  load_balancer_type = var.LOAD_BALANCER["type"]
  security_groups    = [aws_security_group.example.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_lb_target_group" "bookstore_frontend" {
  name     = "frontend-tg"
  port     = 4200
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "ip"
  
  health_check {
    healthy_threshold   = 2
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = 4200
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "bookstore_backend" {
  name     = "backend-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = 2
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = 3000
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "bookstore" {
  load_balancer_arn = aws_lb.bookstore.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bookstore_frontend.arn
  }
}

resource "aws_lb_listener" "bookstore81" {
  load_balancer_arn = aws_lb.bookstore.arn
  port              = "81"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bookstore_backend.arn
  }
}

# resource "aws_lb_listener_rule" "frontend" {
#   listener_arn = aws_lb_listener.bookstore.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.bookstore_frontend.arn
#   }

#   condition {
#     host_header {
#       values = [var.APPLICATION_DOMAIN.FRONTEND]
#     }
#   }
# }

# resource "aws_lb_listener_rule" "backend" {
#   listener_arn = aws_lb_listener.bookstore.arn
#   priority     = 200

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.bookstore_backend.arn
#   }

#   condition {
#     host_header {
#       values = [var.APPLICATION_DOMAIN.BACKEND]
#     }
#   }
# }
