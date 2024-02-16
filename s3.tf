resource "aws_s3_bucket" "ynov-infracloud-schaffnerkelian" {
  bucket = "ynov-infracloud-schaffnerkelian"
}

# Send 'puppy.jpg' file in the bucket 
# The file is located in the folder "assets" in the root of the project
resource "aws_s3_object" "puppy" {
  bucket = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id
  key = "assets/puppy.jpg"
  source = "assets/puppy.jpg"
}

# Public access to the bucket with a policy
resource "aws_s3_bucket_public_access_block" "ynov-infracloud-schaffnerkelian" {
  bucket = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id
  block_public_acls = false
  block_public_policy = false
  #ignore_public_acls = false
  #restrict_public_buckets = false
}
