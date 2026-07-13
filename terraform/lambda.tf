data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../lambda"
  output_path = "../lambda/lambda_function.zip"
}


resource "aws_lambda_function" "processor" {

  filename = data.archive_file.lambda_zip.output_path

  function_name = "aws-data-pipeline-data-processor"

  role = aws_iam_role.lambda_role.arn

  handler = "lambda_function.lambda_handler"

  runtime = "python3.13"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256


  environment {
    variables = {
      RAW_BUCKET       = aws_s3_bucket.raw_data.bucket
      PROCESSED_BUCKET = aws_s3_bucket.processed_data.bucket
    }
  }


  tags = {
    Project     = "aws-data-pipeline"
    Environment = "test"
  }

}
