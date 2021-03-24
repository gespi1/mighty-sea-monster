locals {
  IAM = {
    PREFIX   = "prod-ci"
    SUFFIXES  = true
  }

  TAGS = {
    "standard_tag1" = "one"
    "standard_tag2" = "two"
  }

  iam   = merge(local.IAM, var.iam_overrides)
  tags  = merge(local.TAGS, var.tags_overrides)
  # if not contents found then use defaults
  vars = {
    IAM   = local.iam
    TAGS  = local.tags
  }
}

variable "iam_overrides" {
  type = map
  default = {}
  description = "override vars provided by the module caller."
}

variable "tags_overrides" {
  type = map
  default = {}
  description = "tags go here"
}