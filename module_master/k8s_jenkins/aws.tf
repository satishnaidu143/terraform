resource "aws_vpc" "my_network" {
    cidr_block              = "10.10.0.0/16"
    enable_dns_hostnames    = true
    tags = {
        Name = "myvpc"
    }
}

resource "aws_subnet" "subnet_1" {
    cidr_block              = "10.10.0.0/24"
    vpc_id                  = "${aws_vpc.my_network.id}"
    availability_zone       = "${var.subnet1az}"
    tags = {
        Name = "mysubnet_1"
    }
  
}

resource "aws_subnet" "subnet_2" {
    cidr_block              = "10.10.1.0/24"
    vpc_id                  = "${aws_vpc.my_network.id}"
    availability_zone       = "${var.subnet2az}"
    tags = {
        Name = "mysubnet_2"
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

resource "aws_instance" "master" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.large"
    subnet_id                   = "${aws_subnet.subnet_1.id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${aws_security_group.my_sg.id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "K8s&jenkins"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.master.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "git clone https://github.com/satishnaidu143/install.git",
            "sh install/jenkins.sh",
            "sudo sh install/kube.sh"
        ]
    }
}

