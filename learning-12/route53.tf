data "aws_route53_zone" "root_domain" {
  name = var.ROOT_DOMAIN
}

resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name    = var.APPLICATION_DOMAIN.FRONTEND
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.bookstore.dns_name]
}

resource "aws_route53_record" "backend" {
  zone_id = data.aws_route53_zone.root_domain.zone_id
  name    = var.APPLICATION_DOMAIN.BACKEND
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.bookstore.dns_name]
}