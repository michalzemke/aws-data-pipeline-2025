resource "aws_s3_bucket" "raw_data" {

  bucket = "${var.project_name}-raw-data-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "Raw Data Bucket"
    Environment = "test"
    Project     = var.project_name
  }
}


resource "aws_s3_bucket" "processed_data" {

  bucket = "${var.project_name}-processed-data-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "Processed Data Bucket"
    Environment = "test"
    Project     = var.project_name
  }
}
