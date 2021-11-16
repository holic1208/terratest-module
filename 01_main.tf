provider "aws" {
  region = var.region
}

resource "aws_key_pair" "suuu" {
  key_name   = var.key
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfYmFfDncJ0bZTmiJjtz/p9rZoMsJrD0lpnoNAmTPkqqUA26UHx9T2fUvkxoM9yg6BSQ23HmKorYTaCoNnefq4sTtza1rM96v7MgjB5/cpyhMETeXL7lBBN+5FhhOKQKoQG6XZ5vZl0PgBj9aQ3t7oDrMSlVF6mlsDNyC/XBDEOBtVZ+ECCWiwCC7mCdJD/NEmf+I7ogaMA9LaPuDswPt80S0Qj2R1ZOk4vDAGya5PX/+u5Hla29wbIgvllYA/oeOFVlYN3v6gm3NKgXa98jQeW0/buuB2lt4NK4YyEEQyx/0IotsblxYB0W2gou6cZV2wT1I/Vm7xwFxYjFGsHRmZo3cfP5i+FfDkTluBefRVpSUfWM5C6GeUC40FAb3UQoajgvwf3ViI95cylI0I2+Q2rnChMPZjd7CuMM0JtS+RRqBSmgGY4Kv+sZ8XfOuLXaSYJepekg0om3VAyCAi5CdvvXBfNzpHpFyajU2shBozNOUB91f84B7B22Lw5Gdg9A0="
}

resource "aws_vpc" "suuu" {
  cidr_block = var.cidr_main
  tags = {
    Name = "${var.name}-vpc"
  }
}

# 가용영역 A,C Pub Subnet
resource "aws_subnet" "suuu_pub" {
  count             = length(var.cidr_public) #var에 있는 리스트 값 집어오기! 또는 count = 2
  vpc_id            = aws_vpc.suuu.id
  cidr_block        = var.cidr_public[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    Name = "${var.name}_pub${var.ava[count.index]}"
  }
}

# 가용영역 A,C Pri Subnet
resource "aws_subnet" "suuu_pri" {
  count             = length(var.cidr_private)
  vpc_id            = aws_vpc.suuu.id
  cidr_block        = var.cidr_private[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    Name = "${var.name}_pub${var.ava[count.index]}"
  }
}

# 가용영역 A,C의 DB Subnet
resource "aws_subnet" "suuu_pridb" {
  count             = length(var.cidr_privatedb)
  vpc_id            = aws_vpc.suuu.id
  cidr_block        = var.cidr_privatedb[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    Name = "${var.name}-pridb${var.ava[count.index]}"
  }
}
