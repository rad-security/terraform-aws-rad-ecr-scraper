variable "rad-security_assumed_role_arn" {
  type        = string
  description = "Rad Security Role that will assume the rad-security-connect IAM role you create to interact with resources in your account"
  default     = "arn:aws:iam::955322216602:role/imagescan-scraper"
}

variable "tags" {
  description = "A set of tags to associate with the resources in this module."
  type        = map(string)
  default     = {}
}

variable "aws_external_id" {
  description = "External ID to use when connecting an AWS account with Rad"
  type        = string
  default     = ""
}
