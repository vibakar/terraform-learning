data "aws_route53_zone" "example" {
  name = var.ROOT_DOMAIN
}

resource "aws_route53_record" "example" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = var.APPLICATION_DOMAIN
  type    = "A"
  ttl     = "300"
  records = [aws_eip.example.public_ip]
}