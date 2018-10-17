resource "aws_security_group" "allow-postgres-ingress" {
  name        = "allow-postgres-ingress"
  description = "Allow incoming postgres connections from the VPC."
  vpc_id      = "${var.vpc-id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc-cidr-block}"]
  }
}
