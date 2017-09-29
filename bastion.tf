resource "aws_instance" "bastion" {
  ami = "${module.ami.ami_id}"
  instance_type = "t2.nano"
  subnet_id  = "${aws_subnet.public.id}"
  key_name = "${aws_key_pair.key_pair.key_name}"
  security_groups = [ "${aws_security_group.ecs_cluster.id}" ]
}

resource "aws_eip" "bastion" {}

resource "aws_eip_association" "bastion" {
  instance_id = "${aws_instance.bastion.id}"
  allocation_id = "${aws_eip.bastion.id}"
}

