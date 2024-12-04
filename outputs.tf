output "role_arn" {
  value       = aws_iam_role.rad_ecr_scraper.arn
  description = "AWS IAM Role ARN which Rad Security uses to scan ECR registry."
}
