# Trust Policy
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "AWS"
      identifiers = [var.rad-security_assumed_role_arn]
    }

    dynamic "condition" {
      for_each = var.aws_external_id != "" ? [var.aws_external_id] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [condition.value]
      }
    }
  }
}

# Role
resource "aws_iam_role" "rad_ecr_scraper" {
  name                 = "rad-ecr-scraper"
  path                 = "/"
  max_session_duration = 3600
  description          = "IAM role for rad-ecr-scraper"
  tags                 = var.tags

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# ECR Policy
data "aws_iam_policy_document" "ecr_access" {
  statement {
    actions = [
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["arn:aws:ecr:*:${data.aws_caller_identity.current.account_id}:*"]
    effect    = "Allow"
  }

  statement {
    actions   = ["ecr:DescribeRepositories"]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "ecr_access" {
  name        = "allow_rad_ecr_scraper_to_access_ecr"
  description = "Allows rad-ecr-scraper to read ECR registries."
  policy      = data.aws_iam_policy_document.ecr_access.json
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  policy_arn = aws_iam_policy.ecr_access.arn
  role       = aws_iam_role.rad_ecr_scraper.id
}
