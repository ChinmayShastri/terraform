#Instance defination for shivay-vpc

resource "aws_key_pair" "shivay-key_pair" {
  key_name = "shivay_key_pair"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "shivay-ec2" {
  ami = lookup(var.AMI, var.REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.shivay-key_pair.key_name

  vpc_security_group_ids = [aws_security_group.shivay-sg.id]
  subnet_id = aws_subnet.shivay-public-1.id

  user_data = file("install.sh")

  tags = {
    Name        = "shivay-ec2"
    Description = "Demo project1"
    Environment = "testing"
    Owner       = "chimay.shastri"
  }

}

output "ec2_ip" {
  value = {
    public_ip = aws_instance.shivay-ec2.public_ip
    private_ip = aws_instance.shivay-ec2.private_ip
  }
}