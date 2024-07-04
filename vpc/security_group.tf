#Security group defination for shivay vpc
resource "aws_security_group" "shivay-sg" {
  vpc_id      = aws_vpc.shivay
  name        = "shivay-sg"
  description = "Security group to allow ssh connection for instances under shivay vpc"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name        = "shivay-sg"
    Description = "Demo project1"
    Environment = "testing"
    Owner       = "chimay.shastri"
  }
}