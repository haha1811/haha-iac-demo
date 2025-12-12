output "alarm_topic_arn" {
  value       = aws_sns_topic.alarm_topic.arn
  description = "SNS topic ARN for CloudWatch alarms"
}
