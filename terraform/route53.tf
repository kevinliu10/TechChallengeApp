resource "aws_route53_zone" "private-zone" {
  name = "aws.servian.com"
  comment = "private dns for techchallengeapp"
  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}

resource "aws_route53_record" "private-db-record" {
  zone_id = aws_route53_zone.private-zone.zone_id
  name    = "techchallengeapprds.aws.servian.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.rds.address]
}