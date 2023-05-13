resource "aws_codecommit_repository" "codecommit_repo" {
  count           = var.create_codecommit_repo ? 1 : 0
  repository_name = var.codecommit_repo_name != null ? var.codecommit_repo_name : "codecommit-repo"
  description     = var.codecommit_repo_description
  default_branch  = var.codecommit_repo_default_branch

  tags = merge(
    {
      "AppName" = var.app_name
    },
    var.tags,
  )
}


