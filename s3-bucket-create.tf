
#S3 logging bucket
resource "aws_s3_bucket" "my_log_bucket" {
bucket = "${var.my_log_bucket}"
acl = "log-delivery-write"
force_destroy = true
}

#S3 bucket
resource "aws_s3_bucket" "my_bucket" {
bucket = "${var.my_bucket}"
acl = "private"
logging {
target_bucket = "${aws_s3_bucket.my_log_bucket.id}"
target_prefix = "logs/"
}
}

#S3 bucket notification settings to sns
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.my_bucket.id}"

  topic {
    topic_arn     = "${aws_sns_topic.topic.arn}"
    events        = ["s3:ObjectCreated:*"]
  }
}

