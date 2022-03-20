resource "aws_key_pair" "example" {
  key_name   = "mykey1"
  public_key = file(var.KEY_PATH["public"])
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.example.key_name

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.KEY_PATH["private"])
  }

  tags = { for k, v in var.TAGS : k => lower(v) }
}

output "ip" {
  value = aws_instance.example.public_ip
}