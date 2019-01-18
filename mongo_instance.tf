/*
    mongo-db server
*/
resource "aws_instance" "mongo-server" {
    count = "${lookup(var.mongodb, "count")}"
    ami = "${lookup(var.mongodb, "ami_id")}"
    instance_type = "${lookup(var.mongodb, "instance_type")}"
    key_name = "${aws_key_pair.default.id}"
    subnet_id = "${element(local.priv_subnets, count.index)}"
    vpc_security_group_ids = ["${aws_security_group.mongo-sg.id}"]
    source_dest_check = false
    tags {
      Name = "mongo-server-${count.index + 1}"
      Role = "mongodb"
      mongoMaster = "${count.index == "0" ? "True" : "False"}"
      Env = "dev"
    }
}