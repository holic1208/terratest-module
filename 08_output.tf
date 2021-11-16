output "public_ip" {
  value = aws_instance.suuu_weba.public_ip
  depends_on = [
    aws_eip.suuu_weba_ip
  ]
}

output "alb_dns" {
  value = aws_lb.suuu_alb.dns_name
}