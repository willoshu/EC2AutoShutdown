resource "aws_iam_role" "AWSSystemsManagerDefaultEC2InstanceManagementRole" {
  name = "AWSSystemsManagerDefaultEC2InstanceManagementRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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