## Basic Usage - CodeCommit Repo with Automatic Branch Creation

```hcl
// This is a template file for a basic deployment.
// Modify the parameters below with actual values
module "sample-qs" {
  // location of the module - can be local or git repo
  source = "./modules/novekm-static-website-amplify"


  app_name = "my-app"
  create_codecommit_repo = true
  lookup_existing_codecommit_repo = false
  // see /examples for sample_build_spec
  path_to_build_spec = "novekm/amplify-app/aws"



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
  }
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


# Workshop
For more information, check out my workshop [**Automating Deployment of AWS Amplify Apps with Terraform**](https://catalog.workshops.aws/amplify-with-terraform/)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.35 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.35 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.sample_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |
| [aws_amplify_branch.manual](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch) | resource |
| [aws_amplify_domain_association.amplify_domain_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_domain_association) | resource |
| [aws_codecommit_repository.codecommit_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_iam_role.amplify_codecommit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_user.gitlab_mirroring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.gitlab_mirroring_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_codecommit_repository.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codecommit_repository) | data source |
| [aws_iam_policy_document.amplify_trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.ssm_github_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amplify_codecommit_role_name"></a> [amplify\_codecommit\_role\_name](#input\_amplify\_codecommit\_role\_name) | n/a | `string` | `"amplify-codecommit"` | no |
| <a name="input_app_framework"></a> [app\_framework](#input\_app\_framework) | Framework for the autocreated branch. | `string` | `null` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The name of the Sample Amplify Application. | `string` | `"sample-amplify-app"` | no |
| <a name="input_auto_branch_creation_patterns"></a> [auto\_branch\_creation\_patterns](#input\_auto\_branch\_creation\_patterns) | Automated branch creation glob patterns for the Amplify app. Ex. feat*/* | `list(any)` | <pre>[<br>  "main"<br>]</pre> | no |
| <a name="input_build_spec"></a> [build\_spec](#input\_build\_spec) | The actual content of your build\_spec. Use if 'path\_to\_build\_spec' is not defined. | `string` | `null` | no |
| <a name="input_codecommit_repo_default_branch"></a> [codecommit\_repo\_default\_branch](#input\_codecommit\_repo\_default\_branch) | n/a | `string` | `"main"` | no |
| <a name="input_codecommit_repo_description"></a> [codecommit\_repo\_description](#input\_codecommit\_repo\_description) | n/a | `string` | `"The CodeCommit repo created during the Terraform deployment"` | no |
| <a name="input_codecommit_repo_name"></a> [codecommit\_repo\_name](#input\_codecommit\_repo\_name) | n/a | `string` | `"codecommit_repo"` | no |
| <a name="input_create_codecommit_repo"></a> [create\_codecommit\_repo](#input\_create\_codecommit\_repo) | - CodeCommit - | `bool` | `false` | no |
| <a name="input_create_domain_associations"></a> [create\_domain\_associations](#input\_create\_domain\_associations) | Enables default association of your domain with the 'main' branch of the Amplify App. | `bool` | `false` | no |
| <a name="input_custom_rewrite_and_redirect"></a> [custom\_rewrite\_and\_redirect](#input\_custom\_rewrite\_and\_redirect) | Custom rewrites and redirects for the domain associations. | `map(any)` | <pre>{<br>  "single_page_app": {<br>    "source": "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>",<br>    "status": "200",<br>    "target": "/index.html"<br>  }<br>}</pre> | no |
| <a name="input_domain_associations"></a> [domain\_associations](#input\_domain\_associations) | The domains/subdomains you wish to associate with the Amplify App. These are mapped to git branches. | `map(any)` | `{}` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of your domain. Ex. naruto.ninja | `string` | `"example.com"` | no |
| <a name="input_enable_app_pr_preview"></a> [enable\_app\_pr\_preview](#input\_enable\_app\_pr\_preview) | Enables pull request previews for the autocreated branch. | `bool` | `false` | no |
| <a name="input_enable_auto_branch_creation"></a> [enable\_auto\_branch\_creation](#input\_enable\_auto\_branch\_creation) | Enables automated branch creation for the Amplify app. | `bool` | `false` | no |
| <a name="input_enable_auto_branch_deletion"></a> [enable\_auto\_branch\_deletion](#input\_enable\_auto\_branch\_deletion) | Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository. | `bool` | `false` | no |
| <a name="input_enable_auto_build"></a> [enable\_auto\_build](#input\_enable\_auto\_build) | Enables auto-building of autocreated branches for the Amplify App. | `bool` | `false` | no |
| <a name="input_enable_gitlab_mirroring"></a> [enable\_gitlab\_mirroring](#input\_enable\_gitlab\_mirroring) | Enables GitLab mirroring to the option AWS CodeCommit repo. | `bool` | `false` | no |
| <a name="input_enable_performance_mode"></a> [enable\_performance\_mode](#input\_enable\_performance\_mode) | Enables performance mode for the branch. This keeps cache at Edge Locations for up to 10min after changes. | `bool` | `false` | no |
| <a name="input_existing_codecommit_repo_name"></a> [existing\_codecommit\_repo\_name](#input\_existing\_codecommit\_repo\_name) | n/a | `string` | `null` | no |
| <a name="input_existing_repo_url"></a> [existing\_repo\_url](#input\_existing\_repo\_url) | URL for the existing repo. | `string` | `null` | no |
| <a name="input_github_access_token"></a> [github\_access\_token](#input\_github\_access\_token) | Optional GitHub access token. Only required if using GitHub repo. | `string` | `null` | no |
| <a name="input_gitlab_mirroring_iam_user_name"></a> [gitlab\_mirroring\_iam\_user\_name](#input\_gitlab\_mirroring\_iam\_user\_name) | The IAM Username for the GitLab Mirroring IAM User. | `string` | `null` | no |
| <a name="input_gitlab_mirroring_policy_name"></a> [gitlab\_mirroring\_policy\_name](#input\_gitlab\_mirroring\_policy\_name) | The name of the IAM policy attached to the GitLab Mirroring IAM User | `string` | `"gitlab_mirroring_policy"` | no |
| <a name="input_lookup_existing_codecommit_repo"></a> [lookup\_existing\_codecommit\_repo](#input\_lookup\_existing\_codecommit\_repo) | Conditional fetch of existing CodeCommit repo. | `bool` | `false` | no |
| <a name="input_lookup_ssm_github_access_token"></a> [lookup\_ssm\_github\_access\_token](#input\_lookup\_ssm\_github\_access\_token) | *IMPORTANT!*<br>Conditional data fetch of SSM parameter store for GitHub access token.<br>To ensure security of this token, you must manually add it via the AWS console<br>before using. | `bool` | `false` | no |
| <a name="input_manual_branches"></a> [manual\_branches](#input\_manual\_branches) | List of manual branches you wish to create. | `map(any)` | `{}` | no |
| <a name="input_path_to_build_spec"></a> [path\_to\_build\_spec](#input\_path\_to\_build\_spec) | The path to the location of your build\_spec file. Use if 'build\_spec' is not defined. | `string` | `null` | no |
| <a name="input_ssm_github_access_token_name"></a> [ssm\_github\_access\_token\_name](#input\_ssm\_github\_access\_token\_name) | The name (key) of the SSM parameter store of your GitHub access token | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(any)` | <pre>{<br>  "IAC_PROVIDER": "Terraform"<br>}</pre> | no |
| <a name="input_wait_for_verification"></a> [wait\_for\_verification](#input\_wait\_for\_verification) | If set to 'true', the resource will wait for the domain association status to change to 'PENDING\_DEPLOYMENT' or 'AVAILABLE'. Setting this to false will skip the process. Default is set to 'false'. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_current_region"></a> [aws\_current\_region](#output\_aws\_current\_region) | AWS Current Region |
