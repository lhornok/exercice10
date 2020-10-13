##########################################
# RDS MYSQL                              #
##########################################

resource "aws_db_instance" "mademoizelleDB" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  name                    = "mydb"
  username                = "madadmin"
  password                = local.mysql_password 
  parameter_group_name    = "default.mysql5.7"
  backup_retention_period = 30
  backup_window           = "23:00-23:55"
  maintenance_window      = "Sun:00:00-Sun:03:00"
  db_subnet_group_name    = aws_db_subnet_group.default.id
  # AJOUT AFIN DE POUVOIR FAIRE UN terraform destroy, sinon la commande refuse d'effacer la DB
  final_snapshot_identifier = "madfinalsnapshhot"
  vpc_security_group_ids = ["${aws_security_group.sg_rds.id}"]
}

resource "aws_db_snapshot" "madsnap" {
  db_instance_identifier       = aws_db_instance.mademoizelleDB.id
  db_snapshot_identifier       = "madsnapshot0001"
}

