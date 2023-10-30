resource "aws_sqs_queue" "order_queue" {
  name                      = "order_queue"
  delay_seconds             = 1
  max_message_size          = 20048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

data "aws_iam_policy_document" "iam_sqs_policy_document" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.order_queue.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.order_notification.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.order_queue.id
  policy    = data.aws_iam_policy_document.iam_sqs_policy_document.json
}
