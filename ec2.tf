# EC2 Instance in Private Subnet 1
resource "aws_instance" "ec2-instance-1" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key-name
  subnet_id              = aws_subnet.private-subnet-1.id
  security_groups        = [aws_security_group.security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  root_block_device {
    volume_size = 8
  }
  user_data = templatefile("./tools-install.sh", {})

  tags = {
    Name = "EC2-Instance-1"
  }
}

# EC2 Instance in Private Subnet 2
resource "aws_instance" "ec2-instance-2" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key-name
  subnet_id              = aws_subnet.private-subnet-2.id
  security_groups        = [aws_security_group.security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  root_block_device {
    volume_size = 8
  }
  user_data = templatefile("./toolz-install.sh", {})

  tags = {
    Name = "EC2-Instance-2"
  }
}

# Bastion Host in the public subnet
resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key-name
  subnet_id              = aws_subnet.public-subnet-1.id
  security_groups        = [aws_security_group.security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  root_block_device {
    volume_size = 8
  }
  user_data = templatefile("./tools-install.sh", {})

  tags = {
    Name = var.jumpserver
  }
}