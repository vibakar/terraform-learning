### Creating EC2 instance

We have just created a simple EC2 instance which will have an access to internet.

In this learning, we have created new VPC and using the default resources(Route Table, NACL and Security Group) created by VPC.

Below are the resources created newly,

* EC2 Instance
* VPC
* Subnet
* Internet Gateway
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
