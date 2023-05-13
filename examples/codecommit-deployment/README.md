# CodeCommit Deployment

This deployment path can be used if you wish to use an AWS CodeCommit repo with your Amplify App.

The module can either create a CodeCommit repo and necessary permissions to allow Amplify to access it for you, or you can specify your own CodeCommit repo that already has this configuration.

**IMPORTANT** When using manual branches, if you add additional domain associations beyond what was defined when you first ran `terraform apply`, this will force resource replacement of the Amplify App. The resource will be deleted and recreated, which can lead to downtime. For that reason, it is recommended to use the Auto Branch Creation. That deployment path will not force a resource replacement as long as [**Performance Mode**](https://docs.aws.amazon.com/amplify/latest/userguide/ttl.html) is set to `false` (not enabled). This is the default value for that reason.

The easiest way to push to a CodeCommit Repo is by using [**git-remote-codecommit**](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-git-remote-codecommit.html). Visit the link [**here**](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-git-remote-codecommit.html) for installation instructions.

## Add files to CodeCommit Repo

1. In the top level directory for your code, run `git init` to initialize the directory as a git repo. If you need to redo this step, or have the repo connected to another remote repo that you wish to unlink, run `rm -rf .git` if you need to redo this step, or have the repo connected to another remote repo that you wish to unlink.
2. Connect your local git repo to the remote git repo with `git remote add origin code:commit::<your-aws-region>//<your-repo-name>`. Ex. `git remote add origin code:commit::us-east-1//codecommit_repo`
3. Change default master branch to 'main' with `git branch -M main`
4. Stage all your files with `git add .`
5. Commit your files with `git commit -m "some descriptive message"`
6. Set the upstream to the 'main' branch in your remote repo with `git push -u origin main`
7. Head to the AWS Amplify console and you should see your main branch building.
8. Repeat this for any additional branches you wish to add. Remember for additional branches to auto-build, you must add them to the `auto_branch_creation_patterns`.

## Add your Custom Domain

At this point you can add a custom domain.

1. In `main.tf` set your `domain_name` and also set `create_domain_associations` to true. Also ensure in `domain_associations` you are referencing branches that you actually see in the Amplify Console.
2. Re-apply the terraform code with `terraform apply`
3. Head to the Amplify Console and click `Domain management`. If using a domain managed by Route53, you should automatically see the SSL domain being generated and associated for you.
