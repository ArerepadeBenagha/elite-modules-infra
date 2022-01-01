# resource "aws_s3_bucket_policy" "this" {
#   bucket = aws_s3_bucket.jenkinss3dev.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Id      = "MYBUCKETPOLICY"
#     Statement = [
#       {
#         Sid       = "Allow"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:*"
#         Resource = [
#           aws_s3_bucket.jenkinss3dev.arn,
#           "${aws_s3_bucket.jenkinss3dev.arn}/*",
#         ]
#         Condition = {
#           NotIpAddress = {
#             "aws:SourceIp" = "8.8.8.8/32"
#           }
#         }
#       },
#     ]
#   })
# }