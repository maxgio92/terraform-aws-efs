# terraform-aws-efs

Terraform module that manages AWS EFS filesystem.

This module creates:

- EFS filesystem
- EFS mount targets
- Security group

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_security\_groups | The security group allowed to mount the EFS filesystem | list | n/a | yes |
| default\_tags | The default tags to apply to the resoures | map | `<map>` | no |
| mount\_target\_subnets | The subnets' IDs where to place the EFS mount targets | list | n/a | yes |
| mount\_target\_subnets\_count | The number of subnets where to place the EFS mount targets | string | n/a | yes |
| performance\_mode | The EFS filesystem performance mode.   Can be either "generalPurpose" or "maxIO" (default: "generalPurpose"). | string | `"generalPurpose"` | no |
| prefix\_name | The prefix for the name of the resources | string | `"my"` | no |
| provisioned\_throughput | The throughput, measured in MiB/s, that you want to provision for the EFS filesystem.   Only applicable with "provisioned" throughput mode. | string | `"false"` | no |
| throughput\_mode | Throughput mode for the EFS filesystem (default: "generalPurpose") | string | `"bursting"` | no |
| vpc\_id | The VPC that your EFS filesystem will be hosted in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | The DNS name for the filesystem |
| id | The ID that identifies the file system |

