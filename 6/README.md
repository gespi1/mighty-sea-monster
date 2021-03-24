## AWS setup
configure your aws environment with 
```
aws configure
```

or set your AWS keys and REGION on [aws provider block on main.tf](./main.tf)

## Backend setup
This terraform project uses a S3 backend. Configure your S3 Bucket on the [backend block starting on line 20](./main.tf)


## Module usage
add in your variable overrides on config.yaml , then call your module
```
module "iam" {
  source = "./modules/iam"
  iam_overrides  = local.config.IAM
  tags_overrides = local.config.TAGS
}
```

## test STS Assume Role
generated keys for the user and made an sts call via awscli
```
AWS_ACCESS_KEY_ID=<VALUE> AWS_SECRET_ACCESS_KEY=<VALUE> aws sts assume-role --role-arn arn:aws:iam::<ACCOUNT_ID>:role/<ROLE_NAME> --role-session-name test 
```
