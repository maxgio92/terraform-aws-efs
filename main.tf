# -----------------------------------------------------------------------
# Security group
# -----------------------------------------------------------------------

resource "aws_security_group" "filesystem" {
  name        = "${var.prefix_name}-efs-filesystem"
  description = "${replace(replace(var.prefix_name, "-", " "), "_", " ")} EFS filesystem"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${var.allowed_security_groups}"]
  }

  tags = "${var.default_tags}"
}

# -----------------------------------------------------------------------
# File system
# -----------------------------------------------------------------------

resource "aws_efs_file_system" "bursting_throughput_mode" {
  count = "${var.throughput_mode == "bursting" ? 1 : 0}"

  creation_token   = "${var.prefix_name}-efs"
  performance_mode = "${var.performance_mode}"

  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix_name}-efs"
  ))}"
}

resource "aws_efs_file_system" "provisioned_throughput_mode" {
  count = "${var.throughput_mode == "provisioned" ? 1 : 0}"

  creation_token                  = "${var.prefix_name}-efs"
  throughput_mode                 = "${var.throughput_mode}"
  provisioned_throughput_in_mibps = "${var.provisioned_throughput}"
  performance_mode                = "${var.performance_mode}"

  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix_name}-efs"
  ))}"
}

locals {
  # Workaround for this issue: https://github.com/hashicorp/terraform/issues/18259
  id       = "${var.throughput_mode == "bursting" ? join(",", aws_efs_file_system.bursting_throughput_mode.*.id) : join(",", aws_efs_file_system.provisioned_throughput_mode.*.id)}"
  dns_name = "${var.throughput_mode == "bursting" ? join(",", aws_efs_file_system.bursting_throughput_mode.*.dns_name) : join(",", aws_efs_file_system.provisioned_throughput_mode.*.dns_name)}"
}

# -----------------------------------------------------------------------
# Mount target
# -----------------------------------------------------------------------

resource "aws_efs_mount_target" "alpha" {
  count = "${var.mount_target_subnets_count}"

  file_system_id  = "${local.id}"
  subnet_id       = "${element(var.mount_target_subnets, count.index)}"
  security_groups = ["${aws_security_group.filesystem.id}"]
}
