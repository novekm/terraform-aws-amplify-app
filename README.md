## Basic Usage - CodeCommit Repo with Automatic Branch Creation

```go
// This is a template file for a basic deployment.
// Modify the parameters below with actual values
module "sample-qs" {
  // location of the module - can be local or git repo
  source = "./modules/novekm-static-website-amplify"


  app_name = "my-app"
  create_codecommit_repo = true
  lookup_existing_codecommit_repo = false
  path_to_build_spec = "../amplify.yml"
  // buildspec = ""


  // Auto Branch Creation
  enable_auto_branch_creation   = true
  enable_auto_branch_deletion   = true
  auto_branch_creation_patterns = ["main"]
  enable_auto_build             = true
  enable_app_pr_preview   = true
  app_framework                     = "Something bloated and hard to maintain"


  // - Custom Domain -
  create_domain_associations = false
  domain_name                = "yourdomain.com"
  domain_associations = {
    core = {
      branch_name = "main"
      prefix      = ""
    },
    www = {
      branch_name = "main"
      prefix      = "www"
    },
    // redirect_to_www = {
    //   source = "https://yourdomain.com"
    //   status = "302"
    //   target = "https://www.yourdomain.com" /
    // },
    // dev = {
    //   branch_name = "dev"
    //   prefix = "dev"
    // }
  }


  // custom_rewrite_and_redirect = {
  //   static_site = {
  //     source = "/<*>"
  //     status = "404"
  //     target = "/index.html"
  //   }
  //   single_page_app = {
  //     source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>"
  //     status = "200"
  //     target = "/index.html"
  // }
  //   app2 = {
  //     source = "/app2"
  //     status = "302"
  //     target = "https://yourotherdomain.com"
  //     }
  // }
}
```

# Examples

- [CodeCommit Repo with Auto Branch Creation](https://github.com/novekm/terraform-aws-amplify-app/examples/codecommit-deployment/auto-branch-creation/main.tf)
- [CodeCommit Repo with Manual Branch Creation](https://github.com/novekm/terraform-aws-amplify-app/examples/codecommit-deployment/manual-branch-creation/main.tf)
- [GitHub Repo with Auto Branch Creation](https://github.com/novekm/terraform-aws-amplify-app/examples/github-deployment/auto-branch-creation/main.tf)
- [GitHub Repo with Manual Branch Creation](https://github.com/novekm/terraform-aws-amplify-app/examples/github-deployment/auto-branch-creation/main.tf)
- [GitLab Repo with Auto Branch Creation](https://github.com/novekm/terraform-aws-amplify-app/examples/gitlab-deployment/auto-branch-creation/main.tf)
- [GitLab Repo with Manual Branch Creation](https://github.com/novekm/terraform-aws-amplify-app/examples/gitlab-deployment/auto-branch-creation/main.tf)

# Contributing

Report issues/questions/feature requests on the [issues] page. Reach out to me if you'd like to be a contributor!

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 4.35  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 4.35 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_amplify_app.sample_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app)                                               | resource    |
| [aws_amplify_branch.manual](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch)                                             | resource    |
| [aws_amplify_domain_association.amplify_domain_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_domain_association) | resource    |
| [aws_codecommit_repository.codecommit_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository)                      | resource    |
| [aws_iam_role.amplify_codecommit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                             | resource    |
| [aws_iam_user.gitlab_mirroring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)                                               | resource    |
| [aws_iam_user_policy.gitlab_mirroring_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy)                          | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                                       | data source |
| [aws_codecommit_repository.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codecommit_repository)                              | data source |
| [aws_iam_policy_document.amplify_trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)            | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                                         | data source |
| [aws_ssm_parameter.ssm_github_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                           | data source |

## Inputs

| Name                                                                                                                           | Description                                                                                                                                                                                          | Type        | Default                                                         |  Required  |
| ------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------- | :--------: | --- | --- | --- | --- | --- | --- | --- | ---- | --- | --- | ------------------------------------------------------------------------------------- | --- |
| <a name="input_amplify_codecommit_role_name"></a> [amplify_codecommit_role_name](#input_amplify_codecommit_role_name)          | n/a                                                                                                                                                                                                  | `string`    | `"amplify-codecommit"`                                          |     no     |
| <a name="input_app_framework"></a> [app_framework](#input_app_framework)                                                       | Framework for the autocreated branch.                                                                                                                                                                | `string`    | `null`                                                          |     no     |
| <a name="input_app_name"></a> [app_name](#input_app_name)                                                                      | The name of the Sample Amplify Application.                                                                                                                                                          | `string`    | `"sample-amplify-app"`                                          |     no     |
| <a name="input_auto_branch_creation_patterns"></a> [auto_branch_creation_patterns](#input_auto_branch_creation_patterns)       | Automated branch creation glob patterns for the Amplify app. Ex. feat*/*                                                                                                                             | `list(any)` | <pre>[<br> "main"<br>]</pre>                                    |     no     |
| <a name="input_build_spec"></a> [build_spec](#input_build_spec)                                                                | The actual content of your build_spec. Use if 'path_to_build_spec' is not defined.                                                                                                                   | `string`    | `null`                                                          |     no     |
| <a name="input_codecommit_repo_default_branch"></a> [codecommit_repo_default_branch](#input_codecommit_repo_default_branch)    | n/a                                                                                                                                                                                                  | `string`    | `"main"`                                                        |     no     |
| <a name="input_codecommit_repo_description"></a> [codecommit_repo_description](#input_codecommit_repo_description)             | n/a                                                                                                                                                                                                  | `string`    | `"The CodeCommit repo created during the Terraform deployment"` |     no     |
| <a name="input_codecommit_repo_name"></a> [codecommit_repo_name](#input_codecommit_repo_name)                                  | n/a                                                                                                                                                                                                  | `string`    | `"codecommit_repo"`                                             |     no     |
| <a name="input_create_codecommit_repo"></a> [create_codecommit_repo](#input_create_codecommit_repo)                            | - CodeCommit -                                                                                                                                                                                       | `bool`      | `false`                                                         |     no     |
| <a name="input_create_domain_associations"></a> [create_domain_associations](#input_create_domain_associations)                | Enables default association of your domain with the 'main' branch of the Amplify App.                                                                                                                | `bool`      | `false`                                                         |     no     |
| <a name="input_custom_rewrite_and_redirect"></a> [custom_rewrite_and_redirect](#input_custom_rewrite_and_redirect)             | Custom rewrites and redirects for the domain associations.                                                                                                                                           | `map(any)`  | <pre>{<br> "single_page_app": {<br> "source": "</^[^.]+$        | \\.(?!(css | gif | ico | jpg | js  | png | txt | svg | woff | ttf | map | json)$)([^.]+$)/>",<br> "status": "200",<br> "target": "/index.html"<br> }<br>}</pre> | no  |
| <a name="input_domain_associations"></a> [domain_associations](#input_domain_associations)                                     | The domains/subdomains you wish to associate with the Amplify App. These are mapped to git branches.                                                                                                 | `map(any)`  | `{}`                                                            |     no     |
| <a name="input_domain_name"></a> [domain_name](#input_domain_name)                                                             | The name of your domain. Ex. naruto.ninja                                                                                                                                                            | `string`    | `"example.com"`                                                 |     no     |
| <a name="input_enable_app_pr_preview"></a> [enable_app_pr_preview](#input_enable_app_pr_preview)                               | Enables pull request previews for the autocreated branch.                                                                                                                                            | `bool`      | `false`                                                         |     no     |
| <a name="input_enable_auto_branch_creation"></a> [enable_auto_branch_creation](#input_enable_auto_branch_creation)             | Enables automated branch creation for the Amplify app.                                                                                                                                               | `bool`      | `false`                                                         |     no     |
| <a name="input_enable_auto_branch_deletion"></a> [enable_auto_branch_deletion](#input_enable_auto_branch_deletion)             | Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository.                                                                                         | `bool`      | `false`                                                         |     no     |
| <a name="input_enable_auto_build"></a> [enable_auto_build](#input_enable_auto_build)                                           | Enables auto-building of autocreated branches for the Amplify App.                                                                                                                                   | `bool`      | `false`                                                         |     no     |
| <a name="input_enable_gitlab_mirroring"></a> [enable_gitlab_mirroring](#input_enable_gitlab_mirroring)                         | Enables GitLab mirroring to the option AWS CodeCommit repo.                                                                                                                                          | `bool`      | `false`                                                         |     no     |
| <a name="input_enable_performance_mode"></a> [enable_performance_mode](#input_enable_performance_mode)                         | Enables performance mode for the branch. This keeps cache at Edge Locations for up to 10min after changes.                                                                                           | `bool`      | `false`                                                         |     no     |
| <a name="input_existing_codecommit_repo_name"></a> [existing_codecommit_repo_name](#input_existing_codecommit_repo_name)       | n/a                                                                                                                                                                                                  | `string`    | `null`                                                          |     no     |
| <a name="input_existing_repo_url"></a> [existing_repo_url](#input_existing_repo_url)                                           | URL for the existing repo.                                                                                                                                                                           | `string`    | `null`                                                          |     no     |
| <a name="input_github_access_token"></a> [github_access_token](#input_github_access_token)                                     | Optional GitHub access token. Only required if using GitHub repo.                                                                                                                                    | `string`    | `null`                                                          |     no     |
| <a name="input_gitlab_mirroring_iam_user_name"></a> [gitlab_mirroring_iam_user_name](#input_gitlab_mirroring_iam_user_name)    | The IAM Username for the GitLab Mirroring IAM User.                                                                                                                                                  | `string`    | `null`                                                          |     no     |
| <a name="input_gitlab_mirroring_policy_name"></a> [gitlab_mirroring_policy_name](#input_gitlab_mirroring_policy_name)          | The name of the IAM policy attached to the GitLab Mirroring IAM User                                                                                                                                 | `string`    | `"gitlab_mirroring_policy"`                                     |     no     |
| <a name="input_lookup_existing_codecommit_repo"></a> [lookup_existing_codecommit_repo](#input_lookup_existing_codecommit_repo) | Conditional fetch of existing CodeCommit repo.                                                                                                                                                       | `bool`      | `false`                                                         |     no     |
| <a name="input_lookup_ssm_github_access_token"></a> [lookup_ssm_github_access_token](#input_lookup_ssm_github_access_token)    | _IMPORTANT!_<br>Conditional data fetch of SSM parameter store for GitHub access token.<br>To ensure security of this token, you must manually add it via the AWS console<br>before using.            | `bool`      | `false`                                                         |     no     |
| <a name="input_manual_branches"></a> [manual_branches](#input_manual_branches)                                                 | List of manual branches you wish to create.                                                                                                                                                          | `map(any)`  | `{}`                                                            |     no     |
| <a name="input_path_to_build_spec"></a> [path_to_build_spec](#input_path_to_build_spec)                                        | The path to the location of your build_spec file. Use if 'build_spec' is not defined.                                                                                                                | `string`    | `null`                                                          |     no     |
| <a name="input_ssm_github_access_token_name"></a> [ssm_github_access_token_name](#input_ssm_github_access_token_name)          | The name (key) of the SSM parameter store of your GitHub access token                                                                                                                                | `string`    | `null`                                                          |     no     |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                  | Tags to apply to resources                                                                                                                                                                           | `map(any)`  | <pre>{<br> "IAC_PROVIDER": "Terraform"<br>}</pre>               |     no     |
| <a name="input_wait_for_verification"></a> [wait_for_verification](#input_wait_for_verification)                               | If set to 'true', the resource will wait for the domain association status to change to 'PENDING_DEPLOYMENT' or 'AVAILABLE'. Setting this to false will skip the process. Default is set to 'false'. | `bool`      | `false`                                                         |     no     |

## Outputs

| Name                                                                                      | Description        |
| ----------------------------------------------------------------------------------------- | ------------------ |
| <a name="output_aws_current_region"></a> [aws_current_region](#output_aws_current_region) | AWS Current Region |
