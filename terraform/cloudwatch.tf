resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.processor.function_name}"
  retention_in_days = 14

  tags = {
    Project     = "aws-data-pipeline"
    Environment = "test"
  }
}
