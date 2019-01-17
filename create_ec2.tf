/*
    create jenkins server
*/
resource "aws_instance" "Jenkins-server" {
  #ami = "${lookup(var.amis, var.aws_region)}"
  ami = "ami-0b5eef480feb47fcd"
  instance_type = "${var.jenkins-instance-type}"
  key_name = "${aws_key_pair.default.id}"
  vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]
  subnet_id = "${aws_subnet.pubsub_graylog.id}"
  associate_public_ip_address = true
  source_dest_check = false
  # user_data = "${file("install.sh")}"
  tags {
      Name = "Jenkins-server"
      Role = "jenkins"
      Env = "dev"
    }
} 

/*
    mongo-db server
*/
resource "aws_instance" "mongo-es-server" {
    count = 0
    ami = "${lookup(var.amis, var.aws_region)}"
    instance_type = "${var.mongo-es-instance-type}"
    #key_name = "${var.keyName}"
    key_name = "${aws_key_pair.default.id}"
    subnet_id = "${aws_subnet.privsub_graylog.id}"
    vpc_security_group_ids = ["${aws_security_group.mongo-sg.id}"]
    source_dest_check = false
    
    tags {
      Name = "mongo-es-server-${count.index + 1}"
      Role = "mongo_es-${count.index + 1}"
      Env = "dev"
    }
}
output "private_ips" {
  value = ["${aws_instance.Jenkins-server.private_ip}", "${aws_instance.mongo-es-server.*.private_ip}"]
}
output "public_ips" {
    value = "${aws_instance.Jenkins-server.public_ip}"
}

resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${aws_instance.Jenkins-server.id}"
  }
   connection {
    host = "${aws_instance.Jenkins-server.public_ip}"
  }
    provisioner "file" {
      source = "${var.privatekey_path}"
      destination = "/home/ubuntu/.ssh/id_rsa"
      
      connection {
          type = "ssh"
          user = "ubuntu"
          private_key = "${file(var.privatekey_path)}"
        }
    }
    provisioner "file" {
      source      = "${var.key_path}"
      destination = "/home/ubuntu/.ssh/id_rsa.pub"
      
      connection {
          type        = "ssh"
          user        = "ubuntu"
          private_key = "${file(var.privatekey_path)}"
        }
    }
    provisioner "remote-exec" {
    inline = ["chmod 600 ~/.ssh/id_rsa"]
        
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.privatekey_path)}"
    }
  }
}