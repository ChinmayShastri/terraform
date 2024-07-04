#NAT gateway defination for shivay vpc

#Resource for elastic IP
resource "aws_eip" "shivay-eip" {
  domain          = "vpc"
}

#Resource for NAT gateway
resource "aws_nat_gateway" "shivay-nat" {
    allocation_id = aws_eip.shivay-eip.id
    subnet_id     = aws_subnet.shivay-public-1.id
    depends_on    = [ aws_internet_gateway.shivay-gw ]
}

#Resource for Private route table
resource "aws_route_table" "shivay-rt-private" {
  vpc_id = aws_vpc.shivay.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.shivay-nat.id
  }

  tags = {
    Name        = "shivay-rt-private"
    Description = "Demo project1"
    Environment = "testing"
    Owner       = "chimay.shastri"
  }
}

#Resource for route table association to private subnate

resource "aws_route_table_association" "shivay-private-2-a" {
  subnet_id = aws_subnet.shivay-private-1.id
  route_table_id = aws_route_table.shivay-rt-private.id
}

resource "aws_route_table_association" "shivay-private-2-b" {
  subnet_id = aws_subnet.shivay-private-2.id
  route_table_id = aws_route_table.shivay-rt-private.id
}
