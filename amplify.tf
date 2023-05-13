# Create Amplify App
resource "aws_amplify_app" "sample_app" {
  name       = var.app_name
  repository = var.create_codecommit_repo ? aws_codecommit_repository.codecommit_repo[0].clone_url_http : var.existing_repo_url
  # Auto Branch
  enable_auto_branch_creation   = var.enable_auto_branch_creation
  enable_branch_auto_deletion   = var.enable_auto_branch_deletion
  auto_branch_creation_patterns = var.auto_branch_creation_patterns
  auto_branch_creation_config {
    enable_auto_build           = var.enable_auto_build
    enable_pull_request_preview = var.enable_app_pr_preview
    enable_performance_mode     = var.enable_performance_mode
    framework                   = var.app_framework
  }
  # OPTIONAL - Necessary if not using oauth_token or access_token (used for GitLab and GitHub repos)
  iam_service_role_arn = var.create_codecommit_repo ? aws_iam_role.amplify_codecommit[0].arn : null
  access_token         = var.lookup_ssm_github_access_token ? data.aws_ssm_parameter.ssm_github_access_token[0].value : var.github_access_token // optional, only needed if using github repo
  # build_spec           = file("${path.root}/../amplify.yml")
  build_spec           = var.path_to_build_spec != null ? var.path_to_build_spec : var.build_spec

  dynamic "custom_rule" {
    for_each = var.custom_rewrite_and_redirect == null ? {} : var.custom_rewrite_and_redirect
    content {
      source = lookup(custom_rule.value, "source", "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>")
      status = lookup(custom_rule.value, "status", "200")
      target = lookup(custom_rule.value, "target", "/index.html")
    }
  }
  #  Create App-level Environment Variables
  # environment_variables = {
  #   sample_REGION              = "${data.aws_region.current.id}"
  #   sample_CODECOMMIT_REPO_ID  = "${var.sample_create_codecommit_repo ? aws_codecommit_repository.sample_codecommit_repo[0].repository_id : null}" //return null if no cc repo is created
  #   sample_USER_POOL_ID        = "${aws_cognito_user_pool.sample_user_pool.id}"
  #   sample_IDENTITY_POOL_ID    = "${aws_cognito_identity_pool.sample_identity_pool.id}"
  #   sample_APP_CLIENT_ID       = "${aws_cognito_user_pool_client.sample_user_pool_client.id}"
  #   sample_GRAPHQL_ENDPOINT    = "${aws_appsync_graphql_api.sample_appsync_graphql_api.uris.GRAPHQL}"
  #   sample_GRAPHQL_API_ID      = "${aws_appsync_graphql_api.sample_appsync_graphql_api.id}"
  #   sample_LANDING_BUCKET_NAME = "${aws_s3_bucket.sample_landing_bucket.id}"
  # }
}

# Create Branch-level Environment Variables
resource "aws_amplify_branch" "manual" {
  for_each              = var.manual_branches == null ? {} : var.manual_branches
  app_id                = aws_amplify_app.sample_app.id
  branch_name           = lookup(each.value, "branch_name", null)
  framework             = lookup(each.value, "framework", null)
  stage                 = lookup(each.value, "stage", null)
  environment_variables = lookup(each.value, "environment_variables", null)

}

// Associate your provided domain with the Amplify App
resource "aws_amplify_domain_association" "amplify_domain_association" {
  count       = var.create_domain_associations ? 1 : 0
  wait_for_verification = var.wait_for_verification
  app_id                = aws_amplify_app.sample_app.id
  domain_name = var.domain_name

  dynamic "sub_domain" {
    for_each = var.domain_associations == null ? {} : var.domain_associations
    content {
      branch_name = lookup(sub_domain.value, "branch_name", null)
      prefix      = lookup(sub_domain.value, "prefix", null)
    }
  }

  depends_on = [aws_amplify_branch.manual]
}
