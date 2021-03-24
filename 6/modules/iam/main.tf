data "aws_caller_identity" "current" {}

# using https://registry.terraform.io/providers/hashicorp/aws for reference

resource "aws_iam_role" "role" {
  name = local.vars.IAM.SUFFIXES ? "${local.vars.IAM.PREFIX}-role" : local.vars.IAM.PREFIX
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      },
    ]
  })

  tags = local.vars.TAGS
}

resource "aws_iam_group_policy" "policy" {
  name  = local.vars.IAM.SUFFIXES ? "${local.vars.IAM.PREFIX}-policy" : local.vars.IAM.PREFIX
  group = aws_iam_group.group.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.role.arn
      },
    ]
  })
}

resource "aws_iam_group" "group" {
  name = local.vars.IAM.SUFFIXES ? "${local.vars.IAM.PREFIX}-group" : local.vars.IAM.PREFIX
}

resource "aws_iam_user" "user" {
  name = local.vars.IAM.SUFFIXES ? "${local.vars.IAM.PREFIX}-user" : local.vars.IAM.PREFIX

  tags = local.vars.TAGS
}

resource "aws_iam_user_group_membership" "adduser" {
  user = aws_iam_user.user.name

  groups = [
    aws_iam_group.group.name
  ]
}