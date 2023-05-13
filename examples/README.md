# Terraform Examples Documentation

The examples have two deployment paths:

1. Deployment with Auto Branch Creation
2. Deployment with Manual Branch Creation

## Auto Branch Creation

If you wish to associate domains/subdomains with your application, the branches must exist already. For this to occur with Auto Branch Creation enabled, you must have the code already in a Git Repo, or create a Git Repo and push your code before setting `create_domain_associations` to 'true'. If you have `create_domain_associations` set to true and do not have the designated git branches created, the deployment will fail with the error `cannot associate domain with branch - branch does not exist.`

## Manual Branch Creation

In this deployment path, you would be manually specifying your desired branches in `main.tf` so when running `terraform apply` the branches would be created. This would prevent the error mentioned above because the branch(es) would exist, even if there is no content. Pushing to branches with the same names will trigger the pipeline and associate your domain to the designated branches.
