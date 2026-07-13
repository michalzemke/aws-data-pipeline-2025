resource "aws_iam_role" "lambda_role" {

  name = "${var.project_name}-lambda-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project     = var.project_name
    Environment = "test"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_s3_policy" {

  name = "${var.project_name}-lambda-s3-policy"


  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.raw_data.arn}/*"
        ]
      },


      {
        Effect = "Allow"

        Action = [
          "s3:PutObject"
        ]

        Resource = [
          "${aws_s3_bucket.processed_data.arn}/*"
        ]
      }

    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_s3" {

  role = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}
