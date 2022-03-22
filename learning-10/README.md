### Storing terraform state in S3

In this learning, we are using S3 bucket to store terraform state.

Below are the resources created newly,

* EC2 Instance

#### Note:
We cannot pass aws credentials to s3 backend, instead we have to configure credentials through aws cli.

Follow below steps to configure aws credential
* Run `aws configure`

It will prompt you to enter the aws access key, secret key and default region.

Also terraform will not create S3 Bucket for us to store state file. We have to create S3 bucket manually.
