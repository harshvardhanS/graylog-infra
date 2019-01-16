aws_region = "us-east-1"
count = 1
instance_type = "t2.micro"
key_path = "cred/id_rsa.pub"
privatekey_path = "cred/id_rsa.pub"
amis = {
    #"us-east-1" = "ami-b374d5a5"
    "us-east-1" = "ami-0f9cf087c1f27d9b1"
    "us-west-2" = "ami-4b32be2b"
}
vpc_cidr = "10.0.0.0/16"
public_subnet_cidr = "10.0.0.0/24"
private_subnet_cidr = "10.0.1.0/24"
mongo-es-instance-type = "t2.medium" 