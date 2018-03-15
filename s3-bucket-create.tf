
resource "aws_s3_bucket" "my_log_bucket" {
bucket = "${var.my_log_bucket}"
acl = "log-delivery-write"
}

resource "aws_s3_bucket" "my_bucket" {
bucket = "${var.my_bucket}"
acl = "private"
logging {
target_bucket = "${aws_s3_bucket.my_log_bucket.id}"
target_prefix = "logs/"
}
}
