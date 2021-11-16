resource "aws_security_group" "suuu_sg" {
  name        = "Allow Basic"
  description = "Allow http,ssh,sql,icmp"
  vpc_id      = aws_vpc.suuu.id

  ingress = [
    {
      description      = var.sg_HTTP
      from_port        = var.HTTP_port
      to_port          = var.HTTP_port
      protocol         = var.tcp_protocol
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = var.sg_SSH
      from_port        = var.SSH_port
      to_port          = var.SSH_port
      protocol         = var.tcp_protocol
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = var.sg_SQL
      from_port        = var.SQL_port
      to_port          = var.SQL_port
      protocol         = var.tcp_protocol
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = var.sg_ICMP
      from_port        = var.ALL_port
      to_port          = var.ALL_port
      protocol         = var.icmp_protocol
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      description      = "ALL"
      from_port        = var.ALL_port
      to_port          = var.ALL_port
      protocol         = -1
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ipv6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
  tags = {
    Name = "${var.name}_sg"
  }
}

resource "aws_instance" "suuu_weba" {
  ami                    = "ami-0a5a6128e65676ebb"
  instance_type          = var.instance_type
  key_name               = var.key
  availability_zone      = var.region_instance
  private_ip             = var.ec2_private_ip
  subnet_id              = aws_subnet.suuu_pub[0].id
  vpc_security_group_ids = [aws_security_group.suuu_sg.id]
  user_data              = file("./install.sh")
  tags = {
    Name = "${var.name}-weba"
  }
}

resource "aws_eip" "suuu_weba_ip" {
  vpc                       = var.true
  instance                  = aws_instance.suuu_weba.id
  associate_with_private_ip = var.ec2_private_ip
  depends_on = [
    aws_internet_gateway.suuu_ig
  ]
  tags = {
    Name = "${var.name}ec2-eip"
  }
}

output "public_ip" {
  value = aws_instance.suuu_weba.public_ip
}
