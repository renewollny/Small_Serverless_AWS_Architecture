# Create a lambda function
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "put_order" {
 filename                       = "${path.module}/python/put_order.zip"
 function_name                  = "put_order"
 role                           = aws_iam_role.lambda_role_ue124.arn
 handler                        = "put_order.lambda_handler"
 runtime                        = "python3.11"
}

# Generates an archive from content, a file, or a directory of files.
data "archive_file" "zip_put_order" {
 type        = "zip"
 source_file  = "${path.module}/python/put_order.py"
 output_path = "${path.module}/python/put_order.zip"
}

resource "aws_lambda_event_source_mapping" "s3_mapping" {
  event_source_arn = aws_sqs_queue.order_queue.arn
  enabled          = true
  function_name    = aws_lambda_function.put_order.arn
  batch_size       = 1
}
