############################################# Create VPC ############################################
resource "aws_vpc" "vpc" {
	cidr_block           = var.vpc_cidr
	instance_tenancy     = "default"
	enable_dns_support   = true
	enable_dns_hostnames = true
	tags = {
		Name = "${var.project_prefix}_VPC"
	}
}

############################################ Create the Internet Gateway ############################################
resource "aws_internet_gateway" "VPC_IGW" {
	vpc_id = aws_vpc.vpc.id
	tags = {
		Name = "${var.project_prefix}_VPC_Internet_Gateway"
	}
}

# Create the Route Table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
 	    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.VPC_IGW.id
    }

    tags = {
        Name = "${var.project_prefix}_VPC_public_route_table"
 	}
}

############################################ Create public subnet ############################################
resource "aws_subnet" "public_subnet" {
	vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "172.16.10.0/24"
	map_public_ip_on_launch = false
    availability_zone       = "${var.primary_region}a"
	
 	tags = {
        Name = "${var.project_prefix}_public_subnet"
 	}
}

# Associate the public Route Table with the public Subnet
resource "aws_route_table_association" "public_route_table_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}
