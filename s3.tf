resource "aws_s3_bucket" "ynov-infracloud-schaffnerkelian" {
  bucket = "ynov-infracloud-schaffnerkelian"
}

# Send 'puppy.jpg' file in the bucket 
# The file is located in the folder "assets" in the root of the project
resource "aws_s3_object" "puppy" {
  bucket = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id
  key    = "assets/puppy.jpg"
  source = "assets/puppy.jpg"
}

# Public access to the bucket with a policy
resource "aws_s3_bucket_public_access_block" "ynov-infracloud-schaffnerkelian" {
  bucket                  = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# make public access to the bucket with an AWS policy.
resource "aws_s3_bucket_policy" "ynov-infracloud-schaffnerkelian" {
  bucket     = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id
  depends_on = [aws_s3_bucket_public_access_block.ynov-infracloud-schaffnerkelian]
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.ynov-infracloud-schaffnerkelian.arn}/*",
      },
    ],
  })
}
