output "raw_bucket_name" {
  description = "Raw S3 bucket name"
  value       = aws_s3_bucket.raw_data.bucket
}

output "processed_bucket_name" {
  description = "Processed S3 bucket name"
  value       = aws_s3_bucket.processed_data.bucket
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.processor.function_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.processor.arn
}

output "cloudwatch_log_group" {
  description = "Lambda CloudWatch log group"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}
