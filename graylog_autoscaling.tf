/*
    Graylog server
*/
resource "aws_eip" "graylog_ip" {
  vpc = true
}
resource "aws_launch_configuration" "graylog-launchconfig" {
name_prefix = "graylog-launchconfig"
image_id = "${lookup(var.graylog, "ami_id")}"
instance_type = "${lookup(var.graylog, "instance_type")}"
key_name = "${aws_key_pair.default.key_name}"
security_groups = ["${aws_security_group.graylog-sg.id}"]
#associate_public_ip_address = true
user_data = <<EOF
#cloud-config
runcmd:
  - aws ec2 associate-address --instance-id $(curl http://169.254.169.254/latest/meta-data/instance-id) --allocation-id ${aws_eip.graylog_ip.id} --allow-reassociation
EOF
}
resource "aws_autoscaling_group" "graylog-autoscaling" {
name = "graylog-autoscaling"
vpc_zone_identifier = ["${aws_subnet.terraform-graylog-pubsubnet.*.id}"]
launch_configuration = "${aws_launch_configuration.graylog-launchconfig.name}"
min_size = 1
max_size = 1
health_check_grace_period = 300
health_check_type = "EC2"
force_delete = true
tags = [
    {
        key = "Name"
        value = "graylog-server"
        propagate_at_launch = true
    },
    {
        key = "Role"
        value = "graylog"
        propagate_at_launch = true
    },
    {
        key = "Env"
        value = "dev"
        propagate_at_launch = true
    }]
}