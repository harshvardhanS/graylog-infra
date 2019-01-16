resource "aws_internet_gateway" "graylog_ig" {
    vpc_id = "${aws_vpc.graylog_vpc.id}"
      tags {
        Name = "graylog_igw"
    }
}