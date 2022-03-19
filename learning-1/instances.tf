resource "aws_instance" "example" {
  ami           = "ami-03e88be9ecff64781"
  instance_type = "t2.micro"
}