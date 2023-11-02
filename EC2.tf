resource "aws_instance" "awsec2demo" {
  ami           = "ami-067c21fb1979f0b27" # ap-south-1
  instance_type = "t2.micro"

  tags = {
    Name = "MyEC2Instance" # Specify the desired name for your EC2 instance
  }

  associate_public_ip_address = true
}
