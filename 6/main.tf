terraform {
  required_version = "= 0.14.8"
  required_providers {
    aws = {
      version = "= 3.33.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
# either source your AWS key and region or uncomment and fill in the parameters below
  #region     = ""
  #access_key = ""
  #secret_key = ""
}

# edit the backend respective to your bucket
terraform {
  backend "s3" {
    bucket  = "sea-monster.s3"
    key     = "six/terraform.tfstate"
    region  = "us-east-1"
  }
}

locals {
  config = yamldecode(file("./config.yaml"))
}

module "iam" {
  source = "./modules/iam"
  iam_overrides  = local.config.IAM
  tags_overrides = local.config.TAGS
}