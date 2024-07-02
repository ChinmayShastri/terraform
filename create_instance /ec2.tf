resource "aws_key_pair" "ec2key" {
  key_name = "ec2key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#create AWS Instance
resource "aws_instance" "instance" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2key
  user_data = file("install.sh")

  tags = {
    Name = "basicinstance"
    }
}

output "public_ip" {
    value = aws_instance.instance.public_ip
}
