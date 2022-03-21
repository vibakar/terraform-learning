### Terraform Learnings

#### Directories Info

Directory | Description
------------ | -------------
learning-1 | Creating only EC2 Instance
learning-2 | Creating EC2 Instance and using default security group of default VPC
learning-3 | Creating EC2 Instance and VPC and using default resources in created VPC
learning-4 | Creating EC2 Instance and new VPC, Subnet, NACL, Route Table etc..
learning-5 | Creating EC2 Instance and using provisioner to execute script in local
learning-6 | Creating EC2 Instance and using provisioner to execute script in remote

#### Steps to run each learnings
* Clone this repo
* cd to the respective learning folder
* Add terrform.tfvars file and add AWS_ACCESS_KEY and AWS_SECRET_KEY variables
* run `terraform init` (It will initialize a working directory containing Terraform configuration files)
* run `terraform apply` (It will create the resources)
* run `terraform destroy` (It will delete the resources)
