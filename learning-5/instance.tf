resource "aws_key_pair" "example" {
  key_name   = "mykey1"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "example" {
  ami           = "ami-03e88be9ecff64781"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}

output "ip" {
  value = aws_instance.example.public_ip
}