
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = data.aws_subnet_ids.all.ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "db" {
    allocated_storage           = 20
    storage_type                = "gp2"
    engine                      = "mysql"
    engine_version              = "5.7"
    instance_class              = var.database_instance_class
    identifier                  = var.database_identifier
    name                        = var.database_name
    username                    = var.database_username
    password                    = var.database_password
    parameter_group_name        = "default.mysql5.7"
    db_subnet_group_name        = aws_db_subnet_group.default.name
    vpc_security_group_ids      = [aws_security_group.rds.id]
    multi_az                    = false
    final_snapshot_identifier   = false
    skip_final_snapshot         = true
    publicly_accessible         = true
}