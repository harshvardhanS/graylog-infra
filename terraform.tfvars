aws_region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
subnet_count = 3
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
key_path = {
    "publicKey" = "cred/id_rsa.pub"
    "privateKey" = "cred/id_rsa"
}
jenkins = {
    "instance_type" = "t2.micro"
    "ami_id" = "ami-0506e785eebf38ce8"
    "count" = 1  
}
mongodb = {
    "instance_type" = "t2.micro"
    "ami_id" = "ami-0f9cf087c1f27d9b1"
    "count" = 3
}
elastic = {
    "instance_type" = "t2.medium"
    "ami_id" = "ami-0f9cf087c1f27d9b1"
    "count" = 3
}
graylog = {
    "instance_type" = "t2.medium"
    "ami_id" = "ami-0f9cf087c1f27d9b1"
    "count" = 1
}