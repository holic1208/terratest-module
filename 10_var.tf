variable "true" {
  type = bool
  #  default = true
}

variable "name" {
  type = string
  #  default = "suuu"
}
#id 쪽에는 ${var.name} 사용x!!

variable "region" {
  type = string
  #  default = "ap-northeast-2"
}

variable "region_instance" {
  type = string
  #  default = "ap-northeast-2a"
}

variable "ava" {
  type = list(string)
  #  default = ["a", "c"]
}

variable "key" {
  type = string
  #  default = "suuu-key"
}

variable "cidr_main" {
  type = string
  #  default = "10.0.0.0/16"
}

variable "cidr_public" {
  type = list(string)
  #  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "cidr_private" {
  type = list(string)
  #  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "cidr_privatedb" {
  type = list(string)
  #  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "cidr_route" {
  type = string
  #  default = "0.0.0.0/0"
}

variable "cidr_ipv6" {
  type = string
  #  default = "::/0"
}

variable "sg_ICMP" {
  type = string
  #  default = "Allow ICMP"
}
variable "sg_HTTP" {
  type = string
  #  default = "Allow HTTP"
}

variable "sg_SSH" {
  type = string
  #  default = "Allow SSH"
}

variable "sg_SQL" {
  type = string
  #  default = "Allow SQL"
}

variable "SSH_port" {
  type = number
  #  default = 22
}

variable "HTTP_port" {
  type = number
  #  default = 80
}

variable "SQL_port" {
  type = number
  #  default = 3306
}

variable "ALL_port" {
  type = number
  #  default = 0
}

variable "tcp_protocol" {
  type = string
  #  default = "tcp"
}

variable "icmp_protocol" {
  type = string
  #  default = "icmp"
}

variable "instance_type" {
  type = string
  #  default = "t2.micro"
}

variable "ec2_private_ip" {
  type = string
  #  default = "10.0.0.11"
}

variable "protocol_HTTP" {
  type = string
  #  default = "HTTP"
}

variable "health_path" {
  type = string
  #  default = "/health.html"
}

variable "health_port" {
  type = string
  #  default = "traffic-port"
}

variable "health_type" {
  type = string
  #  default = "EC2"
}

variable "listener_port" {
  type = string
  #  default = "80"
}

variable "RDS_allocate_sto" {
  type = number
  #  default = 20
}

variable "RDS_ins_type" {
  type = string
  #  default = "db.t2.micro"
}

variable "RDS_eng_type" {
  type = string
  #  default = "mysql"
}

variable "RDS_sto_type" {
  type = string
  #  default = "gp2"
}

variable "RDS_version" {
  type = string
  #  default = "8.0"
}
variable "RDS_dbname" {
  type = string
  #  default = "test"
}

variable "RDS_user" {
  type = string
  #  default = "admin"
}

variable "RDS_password" {
  type = string
  #  default = "It12345!"
}

variable "RDS_parag_name" {
  type = string
  #  default = "default.mysql8.0"
}
