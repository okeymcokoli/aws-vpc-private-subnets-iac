vpc-name      = "my-main-vpc"
igw-name      = "main-vpc-igw"
subnet-name   = "main-vpc-subnet"
public-rt-name= "Public-route-table"
private-rt-name = "Private-route-table"
sg-name       = "main-vpc-sg"
instance-name = "ec2-instance-server"
key-name      = "new_demo" #Use your own key
iam-role      = "Instance-iam-role"
ami           = "ami-0e2c8caa4b6378d8c" #use your own ami name
alb_name      = "instance-alb"
target_name   = "my-ec2-target"
listenerName  = "my-ec2-listener"
public-subnet-name-1 = "Public-Subnet-1"
public-subnet-name-2 = "Public-Subnet-2"
private-subnet-name-1 = "Private-Subnet-1"
private-subnet-name-2 = "Private-Subnet-2"
jumpserver    = "BastionHost"