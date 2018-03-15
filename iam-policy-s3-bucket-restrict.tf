data "aws_iam_policy_document" "s3-policy" {
  statement {
    sid = "1"
    effect = "Deny",
    actions = [
      "s3:Delete*",
    ]

    resources = [
      "arn:aws:s3:::${var.my_bucket}"
#      "arn:aws:s3:::${var.my_bucket}/*"
    ]
  }

  statement {
    actions = [
      "s3:List*",
      "s3:Get*",
      "s3:Put*"
    ]

    resources = [
      "arn:aws:s3:::${var.my_bucket}",
    "arn:aws:s3:::${var.my_bucket}/*"]

    }
}

resource "aws_iam_policy" "s3-policy" {
  name   = "s3-bucket-access_terraform"
  path   = "/"
  policy = "${data.aws_iam_policy_document.s3-policy.json}"
}


