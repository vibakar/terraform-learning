resource "aws_autoscaling_group" "bookstore_frontend_asg" {
  name = "BookStore-Frontend-ASG"
  launch_template {
    id      = aws_launch_template.bookstore_frontend.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  max_size            = 3
  min_size            = 2
}


resource "aws_autoscaling_attachment" "frontend" {
  autoscaling_group_name = aws_autoscaling_group.bookstore_frontend_asg.id
  lb_target_group_arn    = aws_lb_target_group.bookstore_frontend.arn
}


resource "aws_autoscaling_group" "bookstore_backend_asg" {
  name = "BookStore-Backend-ASG"
  launch_template {
    id      = aws_launch_template.bookstore_backend.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  max_size            = 3
  min_size            = 2
}


resource "aws_autoscaling_attachment" "backend" {
  autoscaling_group_name = aws_autoscaling_group.bookstore_backend_asg.id
  lb_target_group_arn    = aws_lb_target_group.bookstore_backend.arn
}

resource "aws_autoscaling_policy" "bookstore_frontend_policy" {
  name                   = "bookstore_frontend_policy"
  autoscaling_group_name = aws_autoscaling_group.bookstore_frontend_asg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}

resource "aws_autoscaling_policy" "bookstore_backend_policy" {
  name                   = "bookstore_backend_policy"
  autoscaling_group_name = aws_autoscaling_group.bookstore_backend_asg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}