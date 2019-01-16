/*
    Public subnet
*/

resource "aws_subnet" "pubsub_graylog" {
    vpc_id = "${aws_vpc.graylog_vpc.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "${element(var.azs, 0)}"
    map_public_ip_on_launch = true
    tags {
        Name = "public_subnet_glog"
    }
}

/*
    Private subnet
*/

resource "aws_subnet" "privsub_graylog" {
    vpc_id = "${aws_vpc.graylog_vpc.id}"
    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "${element(var.azs, 0)}"
    tags {
        Name = "private_subnet_glog"
    }
}