resource "aws_sns_topic" "order_notification" {
    name = "order_notification"
}

data "aws_iam_policy_document" "iam_sns_policy_document" {
  statement {
    effect = "Allow"
    actions   = ["SNS:Publish"]
    resources = [aws_sns_topic.order_notification.arn]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.ue124-bucket.arn]
    }
  }
}

resource "aws_sns_topic_policy" "s3_to_sns" {
  arn = aws_sns_topic.order_notification.arn
  policy = data.aws_iam_policy_document.iam_sns_policy_document.json
}

resource "aws_sns_topic_subscription" "order_subscription" {
  topic_arn = aws_sns_topic.order_notification.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order_queue.arn
}