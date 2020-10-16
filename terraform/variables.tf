
variable "aws_region" {
  default = "us-east-2"
}


variable "myip" {
  type    = string
  default = "200.201.187.118/32"
}

variable "manager_instance_type" {
  default = "t3.small"
}

variable "worker_instance_type" {
  default = "t3.small"
}

variable "publickey" {
  default = "../.ssh/swarm-demo.pub"
}
variable "instance_count" {
    default = "3"
}

variable "subnet_count" {
    default = "3"
}

variable "ami" {
  type = map

  default = {
    "us-east-2" = "ami-03657b56516ab7912"
  }
}



##############################
############ DATABASE ########
##############################
variable "database_name" {
  type    = string
  default = "lumisportal"
}

variable "database_username" {
  type    = string
  default = "lumisportal"
}

variable "database_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "database_identifier" {
  type    = string
  default = "lumisportal"
}

variable "database_password" {
  type    = string
  default = "lumisportal"
}