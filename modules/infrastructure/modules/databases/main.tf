resource "aws_db_subnet_group" "rds-private-subnet-group" {
  name       = "rds-private-subnet-group"
  subnet_ids = ["${var.private-a-subnet-id}", "${var.private-b-subnet-id}"]

  tags {
    environment = "${var.environment}"
    sha         = "${var.sha}"
    team        = "${var.team}"
  }
}

resource "aws_db_instance" "master" {
  allocated_storage    = 8
  db_subnet_group_name = "${aws_db_subnet_group.rds-private-subnet-group.name}"
  engine               = "postgres"
  engine_version       = "9.6.3"
  identifier           = "${var.environment}-${var.sha}-master"
  instance_class       = "db.t2.micro"
  multi_az             = true
  name                 = "${var.environment}-${var.sha}-master"
  password             = "password"
  port                 = "5432"
  skip_final_snapshot  = true
  storage_type         = "gp2"
  username             = "username"

  vpc_security_group_ids = [
    "${aws_security_group.allow-postgres-ingress.id}",
  ]
}
