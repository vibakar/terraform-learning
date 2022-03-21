data "aws_key_pair" "example" {
  filter {
    name = "key-name"
    values = ["aws-key*"]
  }
  filter {
    name = "tag:learning"
    values = ["data-source"]
  }
}

resource "aws_instance" "example" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = data.aws_key_pair.example.key_name

  tags = { for k, v in var.TAGS : k => lower(v) }
}

output "key-pair" {
  value = data.aws_key_pair.example.key_name
}

output "ip" {
  value = aws_instance.example.public_ip
}