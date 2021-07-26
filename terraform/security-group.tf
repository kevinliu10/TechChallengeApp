resource "aws_security_group" "app-security-group" {
    name        = "techchallangeapp-app-security-group"
    description = "techchallangeapp-app-security-group"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        from_port       = 3000
        to_port         = 3000
        protocol        = "tcp"
        security_groups = [aws_security_group.alb-security-group.id]
        description     = "Access to port 3000 for load balancer"
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group" "rds-security-group" {
    name        = "techchallangeapp-rds-security-group"
    description = "techchallangeapp-rds-security-group"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        from_port       = 5432
        to_port         = 5432
        protocol        = "tcp"
        security_groups = [aws_security_group.app-security-group.id]
        description     = "Access to port 5432 for application server"
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group" "alb-security-group" {
    name        = "techchallangeapp-alb-security-group"
    description = "techchallangeapp-alb-security-group"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "Access to port 80 for users of application"
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }
}