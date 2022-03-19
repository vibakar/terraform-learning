resource "aws_instance" "example" {
  ami           = "ami-03e88be9ecff64781"
  instance_type = "t2.micro"
}

resource "aws_default_vpc" "example" {
}

resource "aws_default_security_group" "example" {
  vpc_id = aws_default_vpc.example.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}