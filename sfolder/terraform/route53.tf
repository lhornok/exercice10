##########################################
# ROUTE 53                               #
##########################################

resource "aws_route53_zone" "private" {
  name = "mademoizelle.ch"

  vpc {
    vpc_id = aws_vpc.main.id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "www.mademozeille.ch"
  type    = "A"

  alias {
    name                   = aws_elb.mademoizelle.dns_name
    zone_id                = aws_elb.mademoizelle.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "memcached" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "memcached.mademoizelle.ch"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elasticache_cluster.mademoizelle.cluster_address}"]
}

resource "aws_route53_record" "database" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "database.mademoizelle.ch"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_db_instance.mademoizelleDB.address}"]
}

resource "aws_route53_record" "wordpress1" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "wordpress1.mademoizelle.ch"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.wordpress1.private_ip}"]
}

resource "aws_route53_record" "elasticsearch" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "elasticsearch.mademoizelle.ch"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.elasticsearch.private_ip}"]
}

resource "aws_route53_record" "kibana" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "kibana.mademoizelle.ch"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.elasticsearch.private_ip}"]
}

