resource "aws_sns_topic" "was_geht_ab" {
    name = "was_geht_ab"
}

resource "aws_sns_topic_subscription" "name" {
  topic_arn = aws_sns_topic.was_geht_ab.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.terraform_lambda_func.arn
}