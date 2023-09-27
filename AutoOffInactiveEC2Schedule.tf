resource "aws_iam_role" "StartAutomationExecutionRole" {
  name = "StartAutomationExecutionRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "scheduler.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonSSMAutomationRole-attach" {
  role       = aws_iam_role.StartAutomationExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
}

resource "aws_scheduler_schedule" "AutoOffInactiveEC2Schedule" {
  name       = "AutoOffInactiveEC2Schedule"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "rate(15 minutes)"
  schedule_expression_timezone = "America/New_York"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ssm:startAutomationExecution"
    role_arn = aws_iam_role.StartAutomationExecutionRole.arn
    input = jsonencode({
      "DocumentName" : aws_ssm_document.AutoOffAutomationDocument.name
    })
  }
}