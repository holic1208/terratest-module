resource "aws_ami_from_instance" "suuu_ami" {
  name               = "${var.name}-aws.ami"
  source_instance_id = aws_instance.suuu_weba.id

  depends_on = [
    aws_instance.suuu_weba
  ]
  tags = {
    Name = "${var.name}-ami"
  }
}

resource "aws_launch_configuration" "suuu_aslc" {
  name_prefix          = "${var.name}-web-"
  image_id             = aws_ami_from_instance.suuu_ami.id
  instance_type        = var.instance_type
  iam_instance_profile = "admin_role"
  security_groups      = [aws_security_group.suuu_sg.id]
  key_name             = var.key

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_placement_group" "suuu_place" {
  name     = "${var.name}-place"
  strategy = "cluster"
}

# 배치전략? 오토스케일링 할 때 
# cluster,partition,sptread가 있다!

resource "aws_autoscaling_group" "suuu_asg" {
  name                      = "${var.name}-asg"
  min_size                  = 2
  max_size                  = 10
  health_check_grace_period = 10
  health_check_type         = var.health_type
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.suuu_aslc.name
  vpc_zone_identifier       = [aws_subnet.suuu_pub[0].id, aws_subnet.suuu_pub[1].id]
}

resource "aws_autoscaling_attachment" "suuu_asgalbatt" {
  autoscaling_group_name = aws_autoscaling_group.suuu_asg.id
  alb_target_group_arn   = aws_lb_target_group.suuu_albtg.arn
}
