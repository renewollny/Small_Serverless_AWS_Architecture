resource "aws_iam_role" "lambda_role_ue124" {
  name               = "terraform_aws_lambda_role_ue124"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# IAM policy for logging lambda-events
resource "aws_iam_policy" "iam_policy_for_lambda_ue124" {
  name        = "aws_iam_policy_for_terraform_aws_lambda_role_ue124"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role_ue124"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# IAM policy to allow putting items in DynamoDB-table
resource "aws_iam_policy" "put_db_ue124" {
  name        = "aws_iam_policy_for_terraform_put_db_ue124"
  path        = "/"
  description = "AWS IAM Policy to allow lambda to put item into DynamoDB_ue124"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "dynamodb:PutItem",
            "Resource": "arn:aws:dynamodb:eu-central-1:909631119892:table/orders"
        }
    ]
}
EOF
}


# # IAM policy to allow delete items from S3-bucket
# resource "aws_iam_policy" "delete_s3_ue124" {
#   name        = "aws_iam_policy_for_terraform_delete_s3_ue124"
#   path        = "/"
#   description = "AWS IAM Policy to allow lambda to delete item from s3-bucket_ue124"
#   policy      = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "VisualEditor0",
#             "Effect": "Allow",
#             "Action": "s3:DeleteItem",
#             "Resource": "arn:aws:s3:::ue124-bucket/*"
#         }
#     ]
# }
# EOF
# }

resource "aws_iam_policy" "lambda_sqs" {

  name        = "aws_iam_policy_for_terraform_aws_lambda_role_sqs"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sqs:*",
            "Resource": "*"
        }
    ]
}
EOF
}

# resource "aws_iam_policy" "dynamodb_lambda" {
#   name        = "aws_iam_policy_for_terraform_dynamodb_lambda_ue124"
#   path        = "/"
#   description = "AWS IAM Policy to allow lambda to receive dynamodb-stream_ue124"
#   policy      = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "VisualEditor0",
#             "Effect": "Allow",
#             "Action": [
#                 "dynamodb:GetShardIterator",
#                 "dynamodb:DescribeStream",
#                 "dynamodb:ListStreams",
#                 "dynamodb:GetRecords"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }

# Policy Attachment to the role.
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role_ue124.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda_ue124.arn
}
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_put_db" {
  role       = aws_iam_role.lambda_role_ue124.name
  policy_arn = aws_iam_policy.put_db_ue124.arn
}
# resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_delete_s3" {
#   role       = aws_iam_role.lambda_role_ue124.name
#   policy_arn = aws_iam_policy.delete_s3_ue124.arn
# }

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role_sqs" {
  role       = aws_iam_role.lambda_role_ue124.name
  policy_arn = aws_iam_policy.lambda_sqs.arn
}

# resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role_dynamo_lambda" {
#   role       = aws_iam_role.lambda_role_ue124.name
#   policy_arn = aws_iam_policy.dynamodb_lambda.arn
# }
