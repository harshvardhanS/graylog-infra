output "jenkins_ip" {
  value = ["${aws_instance.Jenkins-server.*.public_ip}", "${aws_instance.Jenkins-server.*.private_ip}"]
}

output "mongo_ip" {
  value = ["${aws_instance.mongo-server.*.private_ip}"]
}

output "elastic_ip" {
  value = ["${aws_instance.es-server.*.private_ip}"]
}