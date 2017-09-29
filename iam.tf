# iam role for the ec2 container instances
resource "aws_iam_role" "ecs_container" {
  name = "ecs-container-instance-role"

  assume_role_policy = "${file("iam-policies/assume-role.json")}"
}

resource "aws_iam_role_policy" "ecs_container" {
  name = "ecs-container-role-policy"
  role = "${aws_iam_role.ecs_container.id}"

  policy = "${file("iam-policies/ecs-container-instance.json")}"
}

resource "aws_iam_instance_profile" "ecs_container" {
  name = "windbreaker-ecs-container-instance-profile"
  role = "${aws_iam_role.ecs_container.id}"
}
