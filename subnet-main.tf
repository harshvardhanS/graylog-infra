locals {
  subnet_version = 1
}


resource "aws_subnet" "terraform-graylog-pubsubnet" {
    count = "${var.subnet_count}"
    vpc_id = "${aws_vpc.graylog_vpc.id}"
    availability_zone = "${element(var.availability_zones, count.index)}"
    cidr_block = "10.0.${var.subnet_count * (local.subnet_version - 1)+ count.index + 1}.0/24"
    map_public_ip_on_launch = true
    tags {
    Name = "${element(var.availability_zones, count.index)} pub-subnet-${count.index + 1}"
  }

}
resource "aws_subnet" "terraform-graylog-privsubnet" {
    count = "${var.subnet_count}"
    vpc_id = "${aws_vpc.graylog_vpc.id}"
    availability_zone = "${element(var.availability_zones, count.index)}"
    cidr_block = "10.0.${var.subnet_count * (local.subnet_version + 1 - 1)+ count.index + 1}.0/24"
    tags {
    Name = "${element(var.availability_zones, count.index)} private-subnet-${count.index + 1}"
  }

}