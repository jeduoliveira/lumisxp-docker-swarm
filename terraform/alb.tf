
resource "aws_lb" "alb" {
    name                        = "swarm"
    internal                    = false
    load_balancer_type          = "application"
    security_groups             = [aws_security_group.alb.id]
    subnets                     = data.aws_subnet_ids.all.ids
    enable_deletion_protection  = false
}

resource "aws_lb_listener" "swarm" {
    load_balancer_arn = aws_lb.alb.arn
    port              = "80"
    protocol          = "HTTP"
    
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}

resource "aws_lb_target_group" "tg" {
    name        = "target"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = module.vpc.vpc_id

    stickiness  {
        type = "lb_cookie"
        enabled = true
        cookie_duration = 86400
    }

    #health_check {
    #    enabled = true
    #    path = "/lumis-health.htm"
    #    protocol = "HTTP"
    #    port = "traffic-port"
    #}
}



resource "aws_lb_target_group_attachment" "tg_att" {
  count         = var.instance_manager_count
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        =  element(data.aws_instances.managers.ids, count.index)
  port             = 80
}
