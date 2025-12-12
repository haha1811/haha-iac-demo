############################################
# SNS Topic + Email Subscription
############################################

resource "aws_sns_topic" "alarm_topic" {
  name = "${var.project}-alarms"

  tags = {
    Project = var.project
  }
}

resource "aws_sns_topic_subscription" "alarm_email" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
