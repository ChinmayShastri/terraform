# Provider Configuration
provider "aws" {
  region = "us-east-1"  # Specify the desired AWS region
}

# EC2 Instance with User Data
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your desired AMI
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Welcome to your EC2 instance!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "ExampleInstance"
  }
}