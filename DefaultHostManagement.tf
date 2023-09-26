data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_ssm_service_setting" "default_host_management" {
  setting_id    = "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:servicesetting/ssm/managed-instance/default-ec2-instance-management-role"
  setting_value = "service-role/${aws_iam_role.AWSSystemsManagerDefaultEC2InstanceManagementRole.name}"
}