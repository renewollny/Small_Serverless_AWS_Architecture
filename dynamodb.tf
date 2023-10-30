resource "aws_dynamodb_table" "text_messages" {
  name           = "text_messages"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "Message_Id"

  attribute {
    name = "Message_Id"
    type = "S"
  }

}


resource "aws_dynamodb_table_item" "example" {
  table_name = aws_dynamodb_table.text_messages.name
  hash_key   = aws_dynamodb_table.text_messages.hash_key

  item = jsonencode(
    {
      "Message_Id" : { "S" : "123456" },
      "Message" : { "S" : "Hello World" }
  })

}
