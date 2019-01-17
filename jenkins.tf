/*
    create jenkins server
*/
resource "aws_instance" "Jenkins-server" {
  count = "${lookup(var.jenkins, "count")}"
  ami = "${lookup(var.jenkins, "ami_id")}"
  instance_type = "${lookup(var.jenkins, "instance_type")}"
  key_name = "${aws_key_pair.default.id}"
  subnet_id = "${element(local.pub_subnets, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]
  #associate_public_ip_address = true
  source_dest_check = false
  # user_data = "${file("install.sh")}"
  tags {
      Name = "Jenkins-server-${count.index + 1}"
      Role = "jenkins"
      Env = "dev"
    }
} 
resource "null_resource" "provisioner" {
  # Changes to any instance of the jenkins requires re-provisioning
  count = "${lookup(var.jenkins, "count")}"
  triggers {
    cluster_instance_ids = "${join(",", aws_instance.Jenkins-server.*.id)}"
  }
   connection {
    host = "${element(aws_instance.Jenkins-server.*.public_ip, count.index)}"
  }
  provisioner "file" {
      source = "${lookup(var.key_path, "privateKey")}"
      destination = "/home/ubuntu/.ssh/id_rsa"

      connection {
          type = "ssh"
          user = "ubuntu"
          private_key = "${file(lookup(var.key_path, "privateKey"))}"
      }
  }
  provisioner "file" {
      source      = "${lookup(var.key_path, "publicKey")}"
      destination = "/home/ubuntu/.ssh/id_rsa.pub"

      connection {
          type        = "ssh"
          user        = "ubuntu"
          private_key = "${file(lookup(var.key_path, "privateKey"))}"
      }
  }
  provisioner "remote-exec" {
    inline = ["chmod 600 ~/.ssh/id_rsa"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(lookup(var.key_path, "privateKey"))}"
    }
  }
}
