### Creating EC2 instance

We have just created a simple EC2 instance which will have an access to internet.

In this learning, we have created new vpc, subnets and other resources for ec2 instance, instead of using default resources created by aws.

Below are the resources created newly,

* EC2 Instance
* VPC
* Subnet
* NACL
* Internet Gateway
* Route Table
* Security group
* Network Interface
* Elastic IP

#### EC2 Instance:
Specify AMI ID and Instance type

#### VPC:
Specify CIDR block

#### Subnet:
Specify VPC ID, CIDR block, availability zone

#### NACL:
NACL is a security layer for subnet.
Add required rules and associate it with subnet.
Here we can add both allow and deny rules. It is stateless.

#### Internet Gateway:
Internet Gateway provides the internet access to the instance.
It should be used in route table entry and associate route table with the subnet.
Doing so will provide the internet access to the instances in that subnet.

#### Route Table:
Contains enries to route the traffic.
Associate route table with the subnet.

#### Security Group:
Security group is the security layer at the ec2 instance level.
It will be connected with network interface.
We can add only allow rules and it is stateful.

#### Network Interface:
Network Interface will be attached to the ec2 instance.

#### Elastic IP:
Specify EC2 instance id

## Learning-1 Explained:
* Here we have created 1 VPC and added 1 Subnet, 1 Route Table, 1 NACL, 1 Internet Gateway, 1 Security group under it.
* Added required entries to route table and associated it with subnet.
* Added required rules to NACL and associated it with subnet.
* Added required rules to security groups and attached with network interface.
* Attach network interface with subnet.
* Created EC2 instance will be in the subnet.
* Elastic IP will be associated with the EC2 instance.
