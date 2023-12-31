resource "aws_ssm_document" "AutoOffAutomationDocument" {
  name            = "AutoOffAutomationDocument"
  document_type   = "Automation"
  document_format = "YAML"
  content         = <<DOC
description: |-


  ---
  # AutoOffAutomationDocument
  Auto shutdown ec2 when no user is logged in
  ## How to trigger
  Create an eventbridge scheduled event
schemaVersion: '0.3'
mainSteps:
  - name: AutoOffAutomationDocument
    action: 'aws:runCommand'
    inputs:
      DocumentName: AWS-RunShellScript
      Targets:
        - Key: 'tag:mygroup'
          Values:
            - auto_off
      Parameters:
        commands:
          - 'myuptime=$(cat /proc/uptime | awk ''{print $1}'')'
          - if ( last | grep -q logged )
          - then
          - echo "someone is logged in"
          - 'elif [[ $(echo $${myuptime%.*}) -lt 900 ]]'
          - then
          - echo "system uptime is less than 15 min; will not shutdown"
          - else
          - echo "shutting down in 1 minute"
          - shutdown --halt +1
          - fi
        workingDirectory:
          - ''
        executionTimeout:
          - '3600'
DOC

}