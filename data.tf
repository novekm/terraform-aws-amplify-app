# Current AWS region
data "aws_region" "current" {}

# Current AWS user session info
data "aws_caller_identity" "current" {}
# .account_id
# .arn
# .user_id

# GitHub Access Token SSM Parameter
data "aws_ssm_parameter" "ssm_github_access_token" {
  count = var.lookup_ssm_github_access_token ? 1 : 0
  name  = var.ssm_github_access_token_name
}

data "aws_codecommit_repository" "test" {
  count  = var.lookup_existing_codecommit_repo ? 1 : 0
  repository_name = var.existing_codecommit_repo_name
}
