# # Create a lambda function
# # In terraform ${path.module} is the current directory.
# resource "aws_lambda_function" "delete_order" {
#  filename                       = "${path.module}/python/delete_order.zip"
#  function_name                  = "delete_order"
#  role                           = aws_iam_role.lambda_role_ue124.arn
#  handler                        = "delete_order.lambda_handler"
#  runtime                        = "python3.11"
# }

# # Generates an archive from a file.
# data "archive_file" "zip_delete_order" {
#  type        = "zip"
#  source_file  = "${path.module}/python/delete_order.py"
#  output_path = "${path.module}/python/delete_order.zip"
# }

# resource "aws_lambda_event_source_mapping" "dynamodb_mapping" {
#   event_source_arn = aws_dynamodb_table.orders.stream_arn
#   enabled          = true
#   function_name    = aws_lambda_function.delete_order.arn
#   starting_position = "LATEST"
# }