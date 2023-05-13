# AWS Current Region
output "aws_current_region" {
  value = data.aws_region.current

}

# TODO - Make more outputs

# # S3
# output "sample_input_bucket_id" {
#   value       = aws_s3_bucket.sample_input_bucket
#   description = "The name of the S3 input bucket"
# }
