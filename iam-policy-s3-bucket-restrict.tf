
#IAM policy data for s3 access policy below - buckets created in s3-create-bucket file
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


#IAM s3 access policy provided from above data
resource "aws_iam_policy" "s3-policy" {
  name   = "s3-bucket-access_terraform"
  path   = "/"
  policy = "${data.aws_iam_policy_document.s3-policy.json}"
}

#attach IAM policy to use in user creation file
resource "aws_iam_policy_attachment" "s3-attachment" {
  name       = "s3-policy"
  users      = ["${aws_iam_user.s3-user-lab.name}"]
  policy_arn = "${aws_iam_policy.s3-policy.arn}"
}
