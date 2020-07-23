resource "aws_vpc" "tkd01-vpc01" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "tkd01-vpc01"
  }
}


resource "aws_internet_gateway" "tkd01-igw01" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"

  tags = {
    Name = "tkd01-igw01"
  }
}



resource "aws_nat_gateway" "tkd01-natgw-a" {
  allocation_id = "aws_eip.nat.id"
  subnet_id     = "aws_subnet.tkd01-public-sub-a.id"
  tags = {
    Name = "tkd01-natgw-a"
  }
}

resource "aws_nat_gateway" "tkd01-natgw-b" {
  allocation_id = "aws_eip.nat.id"
  subnet_id     = "aws_subnet.tkd01-public-sub-b.id"
  tags = {
    Name = "tkd01-natgw-b"
  }
}


resource "aws_nat_gateway" "tkd01-natgw-c" {
  allocation_id = "aws_eip.nat.id"
  subnet_id     = "aws_subnet.tkd01-public-sub-c.id"
  tags = {
    Name = "tkd01-natgw-c"
  }
}



# 1st private subnet
  
resource "aws_subnet" "tkd01-private-sub-a" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"
  cidr_block = "10.253.201.0/24"
  availability_zone = "eu-west-2a"
}

resource "aws_security_group" "private-subnet-a-sg" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }


}


# 2nd private subnet

resource "aws_subnet" "tkd01-private-sub-b" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"
  cidr_block = "10.253.202.0/24"
  availability_zone = "eu-west-2b"
}

resource "aws_security_group" "private-subnet-b-sg" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }


}


# 3rd private subnet

resource "aws_subnet" "tkd01-private-sub-c" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"
  cidr_block = "10.253.203.0/24"
  availability_zone = "eu-west-2c"
}

resource "aws_security_group" "private-subnet-c-sg" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }


}


# Routing tables

resource "aws_route_table" "tkd01-private-routing-table-a" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "aws_nat_gateway.tkd01-natgw-a.id"
  }


tags = {
    Name = "tkd01-routing-table-private-a"
  }
}


resource "aws_route_table" "tkd01-private-routing-table-b" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "aws_nat_gateway.tkd01-natgw-b.id"
  }


tags = {
    Name = "tkd01-routing-table-private-b"
  }
}

resource "aws_route_table" "tkd01-private-routing-table-c" {
  vpc_id = "aws_vpc.tkd01-vpc01.id"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "aws_nat_gateway.tkd01-natgw-c.id"
  }


tags = {
    Name = "tkd01-routing-table-private-c"
  }
}


#Private Association
  
resource "aws_route_table_association" "tkd01-private-routing-table-a-private-sub-a"{
    subnet_id = "aws_subnet.tkd01-private-sub-a.id"
    route_table_id = "aws_route_table.tkd01-private-routing-table-a.id"
}

resource "aws_route_table_association" "tkd01-private-routing-table-a-private-sub-b"{
    subnet_id = "aws_subnet.tkd01-private-sub-b.id"
    route_table_id = "aws_route_table.tkd01-private-routing-table-a.id"
}

resource "aws_route_table_association" "tkd01-private-routing-table-a-private-sub-c"{
    subnet_id = "aws_subnet.tkd01-private-sub-c.id"
    route_table_id = "aws_route_table.tkd01-private-routing-table-a.id"
}
                                

