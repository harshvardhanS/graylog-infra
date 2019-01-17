# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "graylogtestkey"
  public_key = "${file("${lookup(var.key_path, "publicKey")}")}"
  lifecycle { 
    ignore_changes = ["public_key"]
} 
}