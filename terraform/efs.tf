########################################################################################
######################################### EFS ##########################################
########################################################################################

resource "aws_efs_file_system" "efs" {
    creation_token = "swarm-demo"

    tags = {
        Name = "EFS Lumis Shared"
    }

    depends_on = [
        module.vpc
    ]
}

resource "aws_efs_mount_target" "efs_mount" {
    for_each        = data.aws_subnet_ids.all.ids
    subnet_id       = each.value
    file_system_id  = aws_efs_file_system.efs.id
    security_groups = [aws_security_group.efs.id] 

    depends_on = [
        aws_efs_file_system.efs
    ]
}