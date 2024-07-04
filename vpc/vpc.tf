#VPC defination:
resource "aws_vpc" "shivay" {
    cidr_block           = "192.168.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name        = "shivay"
        Description = "Demo project1"
        Environment = "testing"
        Owner       = "chimay.shastri"
    }
}

#Subnet defination:
resource "aws_subnet" "shivay-public-1" {
    vpc_id = aws_vpc.shivay.id
    cidr_block = "192.168.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2a"

    tags = {
      Name        = "shivay-public-subnet-1"
      Description = "Demo project1"
      Environment = "testing"
      Owner       = "chimay.shastri"
    }
}

resource "aws_subnet" "shivay-public-2" {
    vpc_id = aws_vpc.shivay.id
    cidr_block = "192.168.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2b"
    
    tags = {
      Name        = "shivay-public-subnet-2"
      Description = "Demo project1"
      Environment = "testing"
      Owner       = "chimay.shastri"
    }
}

resource "aws_subnet" "shivay-private-1" {
    vpc_id = aws_vpc.shivay.id
    cidr_block = "192.168.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2a"

    tags = {
      Name        = "shivay-private-subnet-1"
      Description = "Demo project1"
      Environment = "testing"
      Owner       = "chimay.shastri"
    }
}

resource "aws_subnet" "shivay-private-2" {
    vpc_id = aws_vpc.shivay.id
    cidr_block = "192.168.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2b"

    tags = {
      Name        = "shivay-private-subnet-2"
      Description = "Demo project1"
      Environment = "testing"
      Owner       = "chimay.shastri"
    }
}

#Internet gateway defination:
resource "aws_internet_gateway" "shivay-gw" {
    vpc_id = aws_vpc.shivay.id

    tags = {
      Name = "shivay-gw"
      Description = "Demo project1"
      Environment = "testing"
      Owner       = "chimay.shastri"
    }
}

#Route table defination:
resource "aws_route_table" "shivay-rt-public" {
    vpc_id = aws_vpc.shivay.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.shivay-gw.id
    }
    tags = {
      Name = "shivay-rt-public"
      Description = "Demo project1"
      Environment = "testing"
      Owner       = "chimay.shastri"
    }
}

#Route table association defination:
resource "aws_route_table_association" "shivay-public-2-a" {
    subnet_id      = aws_subnet.shivay-public-1.id
    route_table_id = aws_route_table.shivay-rt-public.id
}

resource "aws_route_table_association" "shivay-public-2-b" {
    subnet_id      = aws_subnet.shivay-public-2.id
    route_table_id = aws_route_table.shivay-rt-public.id
}
