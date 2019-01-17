variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  description = "Ec2 region for VPC"
  default = "us-east-1"
}
variable "vpc_cidr" {}
variable "subnet_count" {}

variable "availability_zones" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "key_path" {
  description = "key files path for key generation"
  type = "map"
}
variable "jenkins" {
  description = "jenkins machine values"
  type = "map"
}
variable "mongodb" {
  description = "mongo machine values"
  type = "map"
}
variable "elastic" {
  description = "mongo machine values"
  type = "map"
}
variable "graylog" {
  description = "mongo machine values"
  type = "map"
}