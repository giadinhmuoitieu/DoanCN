# resource "aws_s3_bucket" "bucket" {
#   bucket = "18dtha2"
#   acl    = "private"
#   lifecycle {
#     prevent_destroy = false
#   }

#   versioning {
#     enabled = true
#   }
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
#   tags = {
#     Name        = "18dtha2"
#     Environment = "Dev"
#   }
# }
# resource "aws_dynamodb_table" "locks" {
#   name         = "locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }

# }

# terraform {
#   backend "s3" {
#     bucket         = "18dtha2"
#     key            = "s3/terraform.tfstate"
#     region         = var.region
#     encrypt        = true
#     dynamodb_table = "locks"
#   }
# }

