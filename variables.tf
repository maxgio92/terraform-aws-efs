variable "vpc_id" {
  description = "The VPC that your EFS filesystem will be hosted in"
}

variable "mount_target_subnets_count" {
  description = "The number of subnets where to place the EFS mount targets"
}

variable "mount_target_subnets" {
  type        = "list"
  description = "The subnets' IDs where to place the EFS mount targets"
}

variable "allowed_security_groups" {
  type        = "list"
  description = "The security group allowed to mount the EFS filesystem"
}

variable "throughput_mode" {
  default     = "bursting"
  description = "Throughput mode for the EFS filesystem (default: \"generalPurpose\")"
}

variable "provisioned_throughput" {
  default = false

  description = <<EOF
  The throughput, measured in MiB/s, that you want to provision for the EFS filesystem.
  Only applicable with "provisioned" throughput mode.
  EOF
}

variable "performance_mode" {
  default = "generalPurpose"

  description = <<EOF
  The EFS filesystem performance mode.
  Can be either "generalPurpose" or "maxIO" (default: "generalPurpose").
  EOF
}

variable "prefix_name" {
  description = "The prefix for the name of the resources"
  default     = "my"
}

variable "default_tags" {
  type        = "map"
  description = "The default tags to apply to the resoures"

  default = {
    Terraform = "true"
  }
}
