
provider "aws" {
  version = ">= 2.28.1"
  region  = var.aws_region
}

resource "aws_key_pair" "swarm_demo" {
  key_name   = "swarm_demo"
  public_key = file(var.publickey)
}

module "manager" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  instance_count              = var.instance_count
  key_name                    = aws_key_pair.swarm_demo.key_name
  name                        = "Manager"
  ami                         = lookup(var.ami,var.aws_region)
  instance_type               = var.manager_instance_type
  cpu_credits                 = "unlimited"
  subnet_ids                  = data.aws_subnet_ids.all.ids
  vpc_security_group_ids      = [aws_security_group.swarm.id]
  associate_public_ip_address = true
  tags = {
      "Environment": "swarm-demo",
      "Node": "manager"

  }
}


module "worker" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  instance_count              = var.instance_count
  key_name                    = aws_key_pair.swarm_demo.key_name
  name                        = "Worker"
  ami                         = lookup(var.ami,var.aws_region)
  instance_type               = var.worker_instance_type
  cpu_credits                 = "unlimited"
  subnet_ids                  = data.aws_subnet_ids.all.ids
  vpc_security_group_ids      = [aws_security_group.swarm.id]
  associate_public_ip_address = true
  tags = {
      "Environment": "swarm-demo",
      "Node": "worker"
  }
}

data "aws_instances" "instances" {
  instance_tags = {
    Environment = "swarm-demo"
  }
  instance_state_names = ["running"]

  depends_on = [
    module.manager,
    module.worker
  ]
}

data "aws_instances" "managers" {
  instance_tags = {
    Node = "manager"
  }
  instance_state_names = ["running"]

  depends_on = [
    module.manager
  ]
}


