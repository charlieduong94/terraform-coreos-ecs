resource "aws_ecs_task_definition" "core" {
  family = "ecs_cluster"
  container_definitions = "${file("container-definitions/core.json")}"
}

