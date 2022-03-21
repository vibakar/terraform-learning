resource "aws_instance" "example" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE

  tags = {for k, v in var.TAGS : k => lower(v)}
}