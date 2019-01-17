variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "keyName" {
    default = "ubuntu_test"
}
variable "aws_region" {
  description = "Ec2 region for VPC"
  default = "us-east-1"
}

variable "amis" {
  description = "amis by region"
  type = "map"
}
variable "vpc_cidr" {}

variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "mongo-es-instance-type" {
  default = "t2.medium"
}

variable "jenkins-instance-type" {
  default = "t2.micro"
}
variable "graylog-instance-type" {
  default = "t2.micro"
}
variable "key_path" {
  description = "SSH Public Key path"
}
variable "privatekey_path" {
  description = "Path to SSH private key to SSH-connect to instances"
}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}