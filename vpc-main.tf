resource "aws_vpc" "graylog_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "graylog-aws-vpc"
    }
}