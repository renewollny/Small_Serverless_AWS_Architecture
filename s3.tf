resource "aws_s3_bucket" "ue124-bucket" {
  bucket = "ue124-bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.ue124-bucket.id
  depends_on = [aws_s3_bucket.ue124-bucket]
  topic {
    topic_arn     = aws_sns_topic.order_notification.arn
    events        = ["s3:ObjectCreated:*"]
  }
}