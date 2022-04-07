### Terraform Learnings

#### Directories Info

Directory | Description
------------ | -------------
learning-1 | Creating only EC2 Instance
learning-2 | Creating EC2 Instance and using default security group of default VPC
learning-3 | Creating EC2 Instance and VPC and using default resources in created VPC
learning-4 | Creating EC2 Instance and new VPC, Subnet, NACL, Route Table etc..
learning-5 | Using provisioner to execute script in local
learning-6 | Using provisioner to execute script in remote
learning-7 | Using modules
learning-8 | Data Source
learning-9 | Attaching EBS volume with EC2 instance. Used Data source and Cloud Init as well
learning-10| Storing terraform state in S3
learning-11| Deploying application as docker image in EC2 instance and adding record in Rout53
learning-12| Creating Auto Scaling Group(ASG), Launch Template(LT), Application Load Balancer(ALB), Route53 Record, Deploying application
learning-13| Deploying application on Amazon managed ECS cluster(Fargate).
learning-14| Creating public and private subnets and enabling the internet access.
learning-15| Creating EKS cluster

#### Steps to run each learnings
* Clone this repo
* cd to the respective learning folder
* Add terrform.tfvars file and add AWS_ACCESS_KEY and AWS_SECRET_KEY variables
* run `terraform init` (It will initialize a working directory containing Terraform configuration files)
* run `terraform apply` (It will create the resources)
* run `terraform destroy` (It will delete the resources)
