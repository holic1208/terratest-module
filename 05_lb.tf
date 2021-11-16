resource "aws_lb" "suuu_alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.suuu_sg.id]
  subnets            = [aws_subnet.suuu_pub[0].id, aws_subnet.suuu_pub[1].id]

  tags = {
    "Name" = "${var.name}_alb"
  }
}

output "alb_dns" {
  value = aws_lb.suuu_alb.dns_name
}

resource "aws_lb_target_group" "suuu_albtg" {
  name     = "${var.name}-albtg"
  port     = var.HTTP_port
  protocol = var.protocol_HTTP
  vpc_id   = aws_vpc.suuu.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200"
    path                = var.health_path
    port                = var.health_port
    protocol            = var.protocol_HTTP
    timeout             = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "suuu_albli" {
  load_balancer_arn = aws_lb.suuu_alb.arn
  port              = var.listener_port
  protocol          = var.protocol_HTTP

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.suuu_albtg.arn
  }
}

resource "aws_lb_target_group_attachment" "suuu_tgatt" {
  target_group_arn = aws_lb_target_group.suuu_albtg.arn
  target_id        = aws_instance.suuu_weba.id
  port             = var.HTTP_port
}
