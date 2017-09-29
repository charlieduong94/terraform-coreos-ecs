resource "aws_ecs_cluster" "cluster" {
  name = "windbreaker"
}

resource "aws_launch_configuration" "cluster" {
  name = "ecs-container-instance-launch-configuration"
  image_id = "${module.ami.ami_id}"
  instance_type = "t2.micro"
  user_data = "${data.template_file.coreos-cloud-config.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_container.id}"
  key_name = "${aws_key_pair.key_pair.key_name}"
  security_groups = [ "${aws_security_group.ecs_cluster.id}" ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "cluster" {
  name = "ecs-cluster-asg"

  launch_configuration = "${aws_launch_configuration.cluster.name}"
  min_size = 2
  max_size = 16

  vpc_zone_identifier = [ "${aws_subnet.private.*.id}" ]

  tag {
    key = "cluster"
    value = ""
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  # depends on cluster being created and private routes
  depends_on = [
    "aws_ecs_cluster.cluster",
    "aws_route.private",
    "aws_route_table_association.private"
  ]
}


