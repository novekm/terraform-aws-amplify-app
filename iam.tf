# --- TRUST RELATIONSHIPS ---
# Amplify Trust Relationship
data "aws_iam_policy_document" "amplify_trust_relationship" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["amplify.amazonaws.com"]
    }
  }
}


# --- IAM ROLES ---
# Amplify
resource "aws_iam_role" "amplify_codecommit" {
  # count               = var.create_codecommit_repo ? 1 : 0
  count               = var.create_codecommit_repo ? 1 : 0
  name                = "${var.amplify_codecommit_role_name}-${var.app_name}"
  assume_role_policy  = data.aws_iam_policy_document.amplify_trust_relationship.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"]
}

# GitLab
resource "aws_iam_user" "gitlab_mirroring" {
  count         = var.enable_gitlab_mirroring ? 1 : 0
  name          = var.gitlab_mirroring_iam_user_name != null ? var.gitlab_mirroring_iam_user_name : "gitlab-mirroring"
  path          = "/${var.app_name}/"
  force_destroy = true // prevents DeleteConflict Error

  tags = merge(
    {
      "AppName" = var.app_name
    },
    var.tags,
  )
}
resource "aws_iam_user_policy" "gitlab_mirroring_policy" {
  count = var.enable_gitlab_mirroring ? 1 : 0
  name  = var.gitlab_mirroring_policy_name
  user  = aws_iam_user.gitlab_mirroring[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "MinimumGitLabMirroringPermissions"
      Action = ["codecommit:GitPull", "codecommit:GitPush"]
      Effect = "Allow"
      Resource = [
        "${aws_codecommit_repository.codecommit_repo[0].arn}"
      ]
    }]

  })

}







