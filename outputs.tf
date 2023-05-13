# TODO - Add more outputs

# AWS Current Region
output "aws_current_region" {
  value = data.aws_region.current

}
output "amplify_app_id" {
  value = aws_amplify_app.sample_app.id
}
output "amplify_app_arn" {
  value = aws_amplify_app.sample_app.arn
}
output "amplify_app_default_domain" {
  value = aws_amplify_app.sample_app.default_domain
}
output "amplify_app_production_branch" {
  value = aws_amplify_app.sample_app.default_domain
}
output "amplify_app_tags_all" {
  value = aws_amplify_app.sample_app.tags_all
}
