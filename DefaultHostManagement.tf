data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_iam_role" "AWSSystemsManagerDefaultEC2InstanceManagementRole" {
  name = "AWSSystemsManagerDefaultEC2InstanceManagementRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ssm.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedEC2InstanceDefaultPolicy-attach" {
  role       = aws_iam_role.AWSSystemsManagerDefaultEC2InstanceManagementRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}

resource "aws_ssm_service_setting" "default_host_management" {
  setting_id    = "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:servicesetting/ssm/managed-instance/default-ec2-instance-management-role"
  setting_value = "service-role/${aws_iam_role.AWSSystemsManagerDefaultEC2InstanceManagementRole.name}"
}