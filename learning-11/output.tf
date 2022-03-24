output "ec2_ip" {
  value = aws_eip.example.public_ip
}

output "key-pair" {
  value = data.aws_key_pair.example.key_name
}

output "zone_name" {
  value = data.aws_route53_zone.example.name
}