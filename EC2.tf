resource "aws_instance" "awsec2demo" {
  ami           = "ami-05c0f5389589545b7" # ap-south-1
  instance_type = "t2.micro"

  tags = {
    Name = "MyEC2Instance" # Specify the desired name for your EC2 instance
  }

  associate_public_ip_address = true
}
