### Creating EC2 instance

Summary:
Creating EC2 Instance
Creating VPC
Creating Subnet in VPC
Creating Internet Gateway in VPC
Creating Route Table in VPC
Adding entry in route table to allow internet access for ec2 instance
Associate route table with subnet
Creating Network Interface in subnet
Creating security group and adding to network interface
Creating Elastic IP
Printing Elastic IP


1) AMI and Instance type is mandatory

    By default there will be 1 default vpc and 3 subnets on the default vpc.
    Also there will be 1 default internet gateway attached to default vpc for internet access.
    And there will be 1 default route table associated with above mentioned 3 subnets.
    Route table will be available in vpc and by default will have an entry to allow internet access.
    NCL(security group at subnet level) attached to subnets, by default will allow all requests.

2) If we don't want to use default vpc, then we have to create below resources
    1) VPC - specify address range
    2) Subnet - specify address range (subset of vpc address range)
    3) Internet Gateway - attach to vpc to get internet access for the vpc
    4) Route table - Create route table in vpc and associate with the subnets and add a entry to allow internet access for the ec2 instances in the subnet
    5) Security group - attach with eni (Security group for instance level, only allow rules can be added)
    6) NCL -  Create NCL in vpc and attach with subnet (Security group for subnet level, we can add allow and deny rule. By default, all requests are allowed)
