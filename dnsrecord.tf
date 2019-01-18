data "aws_route53_zone" "graylog-infra-dns" {
  name = "devops4you.tk"
}

resource "aws_route53_record" "graylog-infra-dns" {
  zone_id = "${data.aws_route53_zone.graylog-infra-dns.zone_id}"
  name    = "www.devops4you.tk"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_elb.graylog-asg-elb.dns_name}"
    zone_id                = "${aws_elb.graylog-asg-elb.zone_id}"
    evaluate_target_health = false
  }
}