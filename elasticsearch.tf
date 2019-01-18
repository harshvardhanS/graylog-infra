/*
    elastic-search server
*/
resource "aws_instance" "es-server" {
    count = "${lookup(var.elastic, "count")}"
    ami = "${lookup(var.elastic, "ami_id")}"
    instance_type = "${lookup(var.elastic, "instance_type")}"
    key_name = "${aws_key_pair.default.id}"
    subnet_id = "${element(local.priv_subnets, count.index)}"
    vpc_security_group_ids = ["${aws_security_group.elastic-sg.id}"]
    source_dest_check = false
    tags {
      Name = "elastic-server-${count.index + 1}"
      Role = "elasticsearch"
      esMaster = "${count.index == "0" ? "True" : "False"}"
      Env = "dev"
    }
}
