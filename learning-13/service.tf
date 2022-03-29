resource "aws_ecs_service" "bookstore" {
  name            = "bookstore"
  cluster         = aws_ecs_cluster.bookstore.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type = "FARGATE"
  health_check_grace_period_seconds = 60

  network_configuration {
    security_groups  = [aws_security_group.example.id]
    subnets          = [aws_subnet.subnet1.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.bookstore_frontend.arn
    container_name   = "bookstore-frontend"
    container_port   = 4200
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.bookstore_backend.arn
    container_name   = "bookstore-backend"
    container_port   = 3000
  }
}