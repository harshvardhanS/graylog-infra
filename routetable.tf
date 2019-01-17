locals {
    pub_subnets = ["${aws_subnet.terraform-graylog-pubsubnet.*.id}"]
    priv_subnets = ["${aws_subnet.terraform-graylog-privsubnet.*.id}"]
}

# Define the route table
resource "aws_route_table" "gl-public-rt" {
    vpc_id = "${aws_vpc.graylog_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.graylog_ig.id}"
    }
    tags {
        Name = "gl-public-rt"
    }
}

# Define private route table
resource "aws_route_table" "gl-private-rt" {
    vpc_id = "${aws_vpc.graylog_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat.id}"
    }
    tags {
        Name = "gl-private-rt"
    }
}

######### PUBLIC Subnet assiosation with rotute table    ######
resource "aws_route_table_association" "public-assoc-1" {
  count = "${var.subnet_count}"
  subnet_id      = "${element(local.pub_subnets, count.index)}"
  route_table_id = "${aws_route_table.gl-public-rt.id}"
}

######### PRIVATE Subnet assiosation with rotute table    ######
resource "aws_route_table_association" "private-assoc-1" {
  count = "${var.subnet_count}"
  subnet_id      = "${element(local.priv_subnets, count.index)}"
  route_table_id = "${aws_route_table.gl-private-rt.id}"
}
