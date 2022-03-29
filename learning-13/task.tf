resource "aws_ecs_task_definition" "task" {
  family = "bookstore"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name      = "bookstore-frontend"
      image     = "vibakar/angular-learning-project-frontend"
      cpu       = 128
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 4200
          hostPort      = 4200
        }
      ]
    },
    {
      name      = "bookstore-backend"
      image     = "vibakar/angular-learning-project-backend"
      cpu       = 128
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}