resource "aws_s3_bucket_website_configuration" "tf-test" {
  bucket = aws_s3_bucket.repo_bucket_3.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket" "repo_bucket_3" {
  bucket = "${var.environment}-${var.platform}-app-web-bucket"
  tags = {
    Name        = "${var.environment}-${var.platform}-app-web-bucket"
    Environment = "${var.environment}-${var.platform}"
  }
}