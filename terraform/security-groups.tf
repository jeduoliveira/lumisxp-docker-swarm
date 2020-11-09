
resource "aws_security_group" "rds" {
    name = "rds"
    vpc_id  = module.vpc.vpc_id
    
    ingress {
        description = "rds"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
        security_groups =  [aws_security_group.swarm.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "swarm" {
    name   = "swarm"
    vpc_id = module.vpc.vpc_id
    
    
    
    ingress {
        description = "Swarm Cluster"
        from_port   = 0
        to_port     = 2377
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    ingress {
        description = "Elasticsearch"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.myip]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "efs" {
    name = "efs"
    vpc_id = module.vpc.vpc_id
    ingress {
        description = "efs"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
       
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
 }

 resource "aws_security_group" "alb" {
    name   = "alb"
    vpc_id = module.vpc.vpc_id
    
    ingress {
        description = "alb"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
       
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

