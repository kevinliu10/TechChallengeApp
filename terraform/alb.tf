resource "aws_alb" "alb" {
    internal        = false
    name            = "techchallenge-alb"
    security_groups = [aws_security_group.alb-security-group.id]
    subnets         = [aws_subnet.public-subnet-az1.id, aws_subnet.public-subnet-az2.id, aws_subnet.public-subnet-az3.id]

    enable_deletion_protection = false
}

resource "aws_lb_listener" "http-listener" {
    load_balancer_arn = aws_alb.alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.target-group.arn
    }
}

resource "aws_lb_target_group" "target-group" {
    name = "techchallengeapp-tg"
    port = 3000
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id
    health_check {
        enabled = true
        interval = 30
        path = "/healthcheck/"
        protocol = "HTTP"
    }
}