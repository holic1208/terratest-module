resource "aws_db_instance" "suuu_rds" {
  allocated_storage      = var.RDS_allocate_sto
  storage_type           = var.RDS_sto_type
  engine                 = var.RDS_eng_type
  engine_version         = var.RDS_version
  instance_class         = var.RDS_ins_type
  name                   = var.RDS_dbname
  identifier             = var.RDS_dbname
  username               = var.RDS_user
  password               = var.RDS_password
  parameter_group_name   = var.RDS_parag_name
  availability_zone      = var.region_instance
  db_subnet_group_name   = aws_db_subnet_group.suuu_dbsb.id
  vpc_security_group_ids = [aws_security_group.suuu_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "${var.name}-rds"
  }
}

resource "aws_db_subnet_group" "suuu_dbsb" {
  name       = "${var.name}-dbsb-group"
  subnet_ids = [aws_subnet.suuu_pridb[0].id, aws_subnet.suuu_pridb[1].id]
  tags = {
    Name = "${var.name}-dbsb-group"
  }
}
