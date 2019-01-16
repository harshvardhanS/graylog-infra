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

# assign the route table to public subnet
resource "aws_route_table_association" "public-rt-subnet-association" {
        subnet_id = "${aws_subnet.pubsub_graylog.id}"
        route_table_id = "${aws_route_table.gl-public-rt.id}"
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

# assign private route table to private subnet
resource "aws_route_table_association" "private-rt-subnet-association" {
        subnet_id = "${aws_subnet.privsub_graylog.id}"
        route_table_id = "${aws_route_table.gl-private-rt.id}"
}
