# AWS VPC with EC2 Instances, Load Balancer, and NAT Gateway using Terraform
Building a highly available and resilient AWS VPC, Private Subnets, and deploying accessible applications using Infrastructure as Code.

![AWS VPC Diagram](./asset/vpc-example-private-subnets.png)

This project demonstrates how to create a **VPC** with **private subnets** and a **NAT Gateway** using **Terraform**. The architecture includes EC2 instances deployed in private subnets, an **Application Load Balancer**, and **Security Groups**.

The infrastructure is built to provide a secure and scalable environment where EC2 instances can communicate with the internet through a NAT Gateway while remaining private.

For a deeper understanding of how to implement private subnets with a NAT gateway in AWS, check out the [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-example-private-subnets-nat.html).This project sets up an AWS Virtual Private Cloud (VPC) with the following components using **Terraform** and **Infrastructure as Code (IaC)** principles:

- **VPC** with two public subnets, private subnets and a NAT Gateway
- **EC2 instances** running in private subnets
- **IAM Roles and Policies** for managing EC2 instances
- **Application Load Balancer** to distribute traffic to EC2 instances
- **Security Groups** and **NAT Gateway** for network security and outbound internet access for private instances
- **Automated tools installation** via a `tools-install.sh` script

### Architecture Overview

The infrastructure includes the following components:

1. **VPC** (`10.0.0.0/16` CIDR block) that spans across two availability zones.
2. **Internet Gateway** (IGW) attached to the VPC for internet connectivity for public subnets.
3. **Public Subnets**: Two public subnets, one in each availability zone (us-east-1a, us-east-1b), where the Bastion Host will be deployed.
4. **Private Subnets**: Two private subnets, one in each availability zone (us-east-1a, us-east-1b), where EC2 instances are deployed.
5. **Route Tables**: A route table for public subnets (routing traffic to the internet through the IGW), and a private route table for private subnets (no direct internet access).
6. **Security Groups**: A security group allowing ingress on ports 22 (SSH), 80 (HTTP), and 8000 for application access.


### Prerequisites

Before running the Terraform scripts, make sure you have the following:

- **Terraform**: [Download Terraform](https://www.terraform.io/downloads.html)
- **AWS Account**: You need an AWS account to provision resources.
- **AWS CLI**: Optionally, install AWS CLI and configure your credentials using `aws configure`.

### Setup Instructions

#### 1. Clone the repository

Clone this repository to your local machine:

```
git clone https://github.com/okeymcokoli/aws-vpc-private-subnets-iac.git
```

2. Configure AWS Credentials
If you haven't already, set up AWS CLI with your credentials:
```
aws configure
```
You will need to provide your AWS Access Key, Secret Key, Region, and Output format.

3. Initialize Terraform
Before applying the Terraform configuration, initialize the project:
```
terraform init
```

4. Customize Variables
You can modify the values in variables.tfvars to customize your deployment.

5. Apply Terraform Configuration
Once everything is set up, you can apply the Terraform configuration to provision the infrastructure:
```
terraform plan -var-file=variables.tfvars
```

```
terraform apply -var-file=variables.tfvars
```

Terraform will prompt you to confirm before creating the resources. Type yes to proceed.

6. Access the Application
Once the infrastructure is created, you can access your application via the Application Load Balancer (ALB) DNS name, which can be found in the EC2 dashboard or by running:

```
terraform output alb_dns_name
```

For the Bastion host, you can SSH into your private instances.

1. copy your pem files from your local to your remote server using the following command
```
scp -i /Path/to/your/.pem key /Path/to/your/.pem key ubuntu@<public-ip-address>:/home/ubuntu/
```

2. ssh into your Bastion Host server and verify key copy is successful.
```
ssh -i /path/to/your-key.pem ec2-user@<bastion-public-ip>
```

3.
```
ls
```

If tools-install.sh fails to install with the right arguments, do the following:

4. Connect to your Ec2-Instances in the Private Subnet through the Bastion Host server

```
ssh -i <key-pair-name> ubuntu@<private-ip-address>
```

5. Create a simple html file and save it.

6. manually start the servers using the following command and access your applications using the load balancer DNS name as shown 6 above:

```
python3 -m http.server 8000
```

7. Teardown the Infrastructure
If you want to destroy all the resources created by Terraform, you can run:

```
terraform destroy -var-file=variables.tfvars
```

This will prompt you to confirm, and then it will remove all the resources.

Description of Terraform Files
- **ec2.tf**: Contains the configuration for launching EC2 instances in private subnets and Bastion Host in the public Subnet.
- **iam-instance-profile.tf**: Defines the IAM Instance Profile used to allow EC2 instances to assume roles.
- **iam-policy.tf**: Specifies the IAM policies attached to EC2 instances for accessing AWS resources.
- **iam-role.tf**: Creates an IAM role with appropriate permissions.
- **loadbalancer.tf**: Configures an Application Load Balancer and the target groups for EC2 instances.
- **provider.tf**: Configures the AWS provider to interact with your AWS account.
- **tools-install.sh**: A shell script that installs necessary tools on EC2 instances during provisioning.
- **variables.tf**: Declares input variables used in the Terraform configuration.
- **variables.tfvars**: Contains the values of the variables used during the Terraform plan/apply.


Contributing
If you want to contribute to this project, feel free to fork the repository and submit a pull request. Please ensure that your changes are well-tested and documented.

License
This project is licensed under the MIT License - see the LICENSE file for details.
