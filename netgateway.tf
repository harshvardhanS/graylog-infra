resource "aws_eip" "natIP" {
    vpc = true
    depends_on = ["aws_internet_gateway.graylog_ig"]
    tags {
        Name = "gl-nate-ip"
    }
}


resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.natIP.id}"
    subnet_id = "${aws_subnet.pubsub_graylog.id}"
    depends_on = ["aws_internet_gateway.graylog_ig"]
    tags {
        Name = "gl-nate-gate"
    }
}
