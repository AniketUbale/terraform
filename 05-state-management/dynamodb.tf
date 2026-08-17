resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "test-state-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "lockID"

  attribute {
    name = "lockID"
    type = "S"
  }
  tags = {
    Name        = "test-state-table"
    Environment = "production"
  }
}