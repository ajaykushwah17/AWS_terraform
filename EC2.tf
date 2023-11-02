provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

## Random
resource "random_pet" "sg" {}

## AWS VPC
resource "aws_vpc" "awsec2demo" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "vpc-quickcloudpocs"
  }
}

## AWS VPC Subnet
resource "aws_subnet" "awsec2demo" {
  vpc_id     = aws_vpc.awsec2demo.id
  cidr_block = "172.16.10.0/24"

  tags = {
    Name = "subnet-quickcloudpocs"
  }
}

## AWS Security Group
resource "aws_security_group" "awsec2demo" {
  name = "${random_pet.sg.id}-sg"
  vpc_id = aws_vpc.awsec2demo.id

  ingress {
    from_port   = 22  # You may need to adjust the port for SSH access
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this for your specific access needs
  }
}

## AWS EC2
resource "aws_instance" "awsec2demo" {
  ami           = "ami-01bc990364452ab3e"  # Replace with a valid AMI ID
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.awsec2demo.id
  vpc_security_group_ids = [aws_security_group.awsec2demo.id]

  tags = {
    Name = "MyEC2Instance"
  }

  associate_public_ip_address = true
}

output "public_ip" {
  value = aws_instance.awsec2demo.public_ip
}
