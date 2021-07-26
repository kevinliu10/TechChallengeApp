resource "aws_vpc" "vpc" {
    cidr_block           = "10.10.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags = {
        Name = "techchallangeapp-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "techchallengeapp-igw"
    }
}

resource "aws_subnet" "app-subnet-az1" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.10.1.0/24"
    availability_zone       = "ap-southeast-2a"
    map_public_ip_on_launch = false

    tags = {
        Name = "techchallangeapp-app-subnet-az1"
    }
}

resource "aws_subnet" "app-subnet-az2" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.10.2.0/24"
    availability_zone       = "ap-southeast-2b"
    map_public_ip_on_launch = false

    tags = {
        Name = "techchallangeapp-app-subnet-az2"
    }
}

resource "aws_subnet" "app-subnet-az3" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.10.3.0/24"
    availability_zone       = "ap-southeast-2c"
    map_public_ip_on_launch = false

    tags = {
        Name = "techchallangeapp-app-subnet-az3"
    }
}

resource "aws_subnet" "public-subnet-az1" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.10.11.0/24"
    availability_zone       = "ap-southeast-2a"
    map_public_ip_on_launch = false

    tags = {
        Name = "techchallangeapp-public-subnet-az1"
    }
}

resource "aws_subnet" "public-subnet-az2" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.10.12.0/24"
    availability_zone       = "ap-southeast-2b"
    map_public_ip_on_launch = false

    tags = {
        Name = "techchallangeapp-public-subnet-az2"
    }
}

resource "aws_subnet" "public-subnet-az3" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.10.13.0/24"
    availability_zone       = "ap-southeast-2c"
    map_public_ip_on_launch = false

    tags = {
        Name = "techchallangeapp-public-subnet-az3"
    }
}


resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "techchallangeapp-rds-subnet-group"
  subnet_ids = [aws_subnet.app-subnet-az1.id, aws_subnet.app-subnet-az2.id, aws_subnet.app-subnet-az3.id]
  description = "techchallangeapp rds subnet group"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "nat-eip" {
    vpc               = true

    tags = {
        Name = "techchallengeapp-nat-eip"
    }
}

resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.public-subnet-az1.id

    tags = {
        Name = "techchallengeapp-nat-gateway"
    }
}

resource "aws_route_table" "public-routetable" {
    vpc_id     = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "techchallenge-public-routetable"
    }
}

resource "aws_route_table" "private-routetable" {
    vpc_id     = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway.id
    }

    tags = {
        Name = "techchallenge-private-routetable"
    }
}

resource "aws_route_table_association" "rta-app-1" {
    route_table_id = aws_route_table.private-routetable.id
    subnet_id = aws_subnet.app-subnet-az1.id
}

resource "aws_route_table_association" "rta-app-2" {
    route_table_id = aws_route_table.private-routetable.id
    subnet_id = aws_subnet.app-subnet-az2.id
}

resource "aws_route_table_association" "rta-app-3" {
    route_table_id = aws_route_table.private-routetable.id
    subnet_id = aws_subnet.app-subnet-az3.id
}

resource "aws_route_table_association" "rta-public-1" {
    route_table_id = aws_route_table.public-routetable.id
    subnet_id = aws_subnet.public-subnet-az1.id
}

resource "aws_route_table_association" "rta-public-2" {
    route_table_id = aws_route_table.public-routetable.id
    subnet_id = aws_subnet.public-subnet-az2.id
}

resource "aws_route_table_association" "rta-public-3" {
    route_table_id = aws_route_table.public-routetable.id
    subnet_id = aws_subnet.public-subnet-az3.id
}