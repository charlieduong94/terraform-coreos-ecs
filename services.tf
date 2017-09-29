resource "aws_ecs_service" "core" {
  name = "core"
  cluster = "${aws_ecs_cluster.cluster.id}"
  task_definition = "${aws_ecs_task_definition.core.arn}"
  desired_count = 2
}
