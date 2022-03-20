resource "aws_key_pair" "example" {
  key_name   = "mykey1"
  public_key = file(var.KEY_PATH["public"])
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.example.key_name

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }

  tags = { for k, v in var.TAGS : k => lower(v) }
}

output "ip" {
  value = aws_instance.example.public_ip
}