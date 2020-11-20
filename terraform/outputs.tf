#output "instances" {
#    value = data.aws_instances.instances.public_ips
#}

output "aws_subnet_ids" {
    value = data.aws_subnet_ids.all.ids
}

output "efs" {
    value = aws_efs_file_system.efs.dns_name
}
