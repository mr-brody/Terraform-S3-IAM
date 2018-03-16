

The purpose of this repo is:

Allow a user programmatic access to an S3 bucket but deny deletes on the bucket

    *create two S3 buckets via input variables, one allowing access for a user an one for logging actions. Use the user bucket defined as the 'my_bucket' variable later to build the IAM policy[1]
    *create an IAM user and access key (output creds to the console --> optionally use a pgp key)[2]
    *create IAM s3 policy for all actions except deletes for the aforemented variable[3]
    *Attach the IAM policy to the user, allowing them access to the resources[4]

Monitor actions on the bucket via a lambda function. The function will send notifications to an SNS topic

    *create a notification trigger on the logging S3 bucket
    *create a lambda function to trigger when new files are added to the bucket
    *create an SNS topic template
    *create an SNS subscription template
    *triggers on new resource creation
    *sns topic will send notiication to lambda, lambda sends webhook to the desired url

Pending https://www.terraform.io/docs/providers/aws/r/s3_bucket_notification.html

Key notes:

    *Ensure credentials aren't checked into github (can use gitignore although local creds are defined in the provier file)

https://www.terraform.io/docs/providers/aws/r/s3_bucket.html[1] https://www.terraform.io/docs/providers/aws/r/iam_access_key.html[2] https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html[3] https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html[4]
