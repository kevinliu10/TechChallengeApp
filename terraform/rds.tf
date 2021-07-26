resource "aws_db_instance" "rds" {
    identifier                = "techchallengeapp-rds"
    allocated_storage         = 20
    max_allocated_storage     = 40
    storage_type              = "gp2"
    engine                    = "postgres"
    engine_version            = "12.5"
    instance_class            = "db.t2.micro"
    username                  = "postgres"
    password                  = "letmein123"
    port                      = 5432
    publicly_accessible       = false
    availability_zone         = "ap-southeast-2a"
    vpc_security_group_ids    = [aws_security_group.rds-security-group.id]
    db_subnet_group_name      = aws_db_subnet_group.db-subnet-group.id
    parameter_group_name      = "default.postgres12"
    # multi_az set to off as it increases dpeloyment time. Set to true for higher db availability.
    multi_az                  = false
    deletion_protection       = false
    skip_final_snapshot       = true
}