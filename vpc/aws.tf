provider "aws" {
   region       = "${var.region}"
   access_key   = "${var.accesskey}"
   secret_key   = "${var.secretkey}"
}
resource "aws_vpc" "my_network" {
    cidr_block              = "10.10.0.0/16"
    enable_dns_hostnames    = true
    tags = {
        Name = "my_network"
    }
}

resource "aws_subnet" "subnet_1" {
    cidr_block              = "10.10.0.0/24"
    vpc_id                  = "${aws_vpc.my_network.id}"
    availability_zone       = "${var.subnet1az}"
    tags = {
        Name = "subnet_1"
    }
  
}

resource "aws_subnet" "subnet_2" {
    cidr_block              = "10.10.1.0/24"
    vpc_id                  = "${aws_vpc.my_network.id}"
    availability_zone       = "${var.subnet2az}"
    tags = {
        Name = "subnet_2"
    }
  
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id      = "${aws_vpc.my_network.id}"
    tags = {
        Name = "my_igw"
    }
  
}

resource "aws_route_table" "my_rt" {
    vpc_id = "${aws_vpc.my_network.id}"

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = "${aws_internet_gateway.my_igw.id}"
    }

    tags = {
        Name = "my_rt"
    }
  
}

resource "aws_security_group" "my_sg" {
    name            = "my_sg"
    description     = "created from terraform"
    vpc_id          = "${aws_vpc.my_network.id}"
    ingress{
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = "0"
        to_port     = "0"
    }
    egress{
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = "0"
        to_port     = "0"
    }
    tags = {
        Name = "my_sg"
    }
}

resource "aws_route_table_association" "subnet1assoc" {
    subnet_id       = "${aws_subnet.subnet_1.id}"
    route_table_id  = "${aws_route_table.my_rt.id}"
  
}

resource "aws_route_table_association" "subnet2assoc" {
    subnet_id       = "${aws_subnet.subnet_2.id}"
    route_table_id  = "${aws_route_table.my_rt.id}"
  
}