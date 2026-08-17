resource "aws_s3_bucket" "state-bucket" {
  bucket = "test-state-bucket"

  tags = {
    Name        = "test-state-bucket"
  }
}