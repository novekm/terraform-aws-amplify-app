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
