resource "aws_iam_role" "lambda_role_ue123" {
 name   = "terraform_aws_lambda_role_ue123"
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
resource "aws_iam_policy" "iam_policy_for_lambda_ue123" {
  name         = "aws_iam_policy_for_terraform_aws_lambda_role_ue123"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role_ue123"
  policy = <<EOF
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

# IAM policy to allow putting items in an S3-bucket
resource "aws_iam_policy" "put_db_ue123" {
  name         = "aws_iam_policy_for_terraform_put_db_ue123"
  path         = "/"
  description  = "AWS IAM Policy to allow lambda put item into DynamoDB_ue123"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "dynamodb:PutItem",
            "Resource": "arn:aws:dynamodb:eu-central-1:909631119892:table/text_messages"
        }
    ]
}
EOF
}

# Policy Attachment to the role.
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role_ue123.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda_ue123.arn
}
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role2" {
  role        = aws_iam_role.lambda_role_ue123.name
  policy_arn  = aws_iam_policy.put_db_ue123.arn
}