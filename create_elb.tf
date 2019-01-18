### Creating ELB
resource "aws_elb" "graylog-asg-elb" {
  #count = "${var.subnet_count}"
  name = "graylog-asg-elb"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = ["${aws_subnet.terraform-graylog-pubsubnet.*.id}"]
  #availability_zones = ["${element(var.availability_zones, count.index)}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener = [{
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  },
  {
    lb_port = 9000
    lb_protocol = "http"
    instance_port = "9000"
    instance_protocol = "http"
  }]

}

## Security Group for ELB
resource "aws_security_group" "elb" {
  name = "terraform-example-elb"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.graylog_vpc.id}"
    tags {
        Name = "elb-sg"
    }
}