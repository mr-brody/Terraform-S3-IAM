
resource "aws_iam_user" "s3-user-lab" {
  name = "s3-user-lab"
  path = "/"
}

resource "aws_iam_access_key" "s3-user-lab" {
  user = "${aws_iam_user.s3-user-lab.name}"
#  pgp_key = "keybase:mbrodyterraform"
}

output "id" {
  value = "${aws_iam_access_key.s3-user-lab.id}"
}

output "secret" {
  value = "${aws_iam_access_key.s3-user-lab.secret}"
}

resource "aws_iam_policy_attachment" "s3-attachment" {
  name       = "s3-policy"
  users      = ["${aws_iam_user.s3-user-lab.name}"]
  policy_arn = "${aws_iam_policy.s3-policy.arn}"
}
