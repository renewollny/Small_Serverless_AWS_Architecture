resource "aws_dynamodb_table" "orders" {
  name           = "orders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "Order_Id"
  # stream_enabled = true
  # stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "Order_Id"
    type = "S"
  }
}