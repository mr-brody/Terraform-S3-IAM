
#lambda-triggered-from-sns
resource "aws_lambda_function" "lambda-bot" {
  filename         = "lambda-function.zip"
  function_name    = "lambda-bot"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "lambda.handler"
  runtime          = "python3.6"
  description = "Function to send webhooks for new bucket objects"
}

#lambda-invoke-permissions
resource "aws_lambda_permission" "with_sns" {
    statement_id = "AllowExecutionFromSNS"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda-bot.arn}"
    principal = "sns.amazonaws.com"
    source_arn = "${aws_sns_topic.topic.arn}"
}

#definition for lambda role
resource "aws_iam_role" "lambda_exec_role" {
  name        = "lambda_exec"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#lambda-role-policy
resource "aws_iam_role_policy" "cwl_policy" {
  name = "cwl_policy"
  role = "${aws_iam_role.lambda_exec_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Resource": "*",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}
