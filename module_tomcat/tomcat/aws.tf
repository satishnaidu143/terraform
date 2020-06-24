resource "aws_vpc" "rideeasy_network" {
    cidr_block              = "10.10.0.0/16"
    enable_dns_hostnames    = true
    tags = {
        Name = "rideeasy"
    }
}

resource "aws_subnet" "subnet_1" {
    cidr_block              = "10.10.0.0/24"
    vpc_id                  = "${aws_vpc.rideeasy_network.id}"
    availability_zone       = "${var.subnet1az}"
    tags = {
        Name = "rideeasy"
    }
  
}

resource "aws_subnet" "subnet_2" {
    cidr_block              = "10.10.1.0/24"
    vpc_id                  = "${aws_vpc.rideeasy_network.id}"
    availability_zone       = "${var.subnet2az}"
    tags = {
        Name = "rideeasy"
    }
  
}

resource "aws_internet_gateway" "rideeasy_igw" {
    vpc_id      = "${aws_vpc.rideeasy_network.id}"
    tags = {
        Name = "rideeasy"
    }
  
}

resource "aws_route_table" "rideeasy_rt" {
    vpc_id = "${aws_vpc.rideeasy_network.id}"

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = "${aws_internet_gateway.rideeasy_igw.id}"
    }

    tags = {
        Name = "rideeasy"
    }
  
}

resource "aws_security_group" "rideeasy_sg" {
    name            = "my_sg"
    description     = "created from terraform"
    vpc_id          = "${aws_vpc.rideeasy_network.id}"
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
        Name = "rideeasy"
    }
}

resource "aws_route_table_association" "subnet1assoc" {
    subnet_id       = "${aws_subnet.subnet_1.id}"
    route_table_id  = "${aws_route_table.rideeasy_rt.id}"
  
}

resource "aws_route_table_association" "subnet2assoc" {
    subnet_id       = "${aws_subnet.subnet_2.id}"
    route_table_id  = "${aws_route_table.rideeasy_rt.id}"
  
}

resource "aws_instance" "web1" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.subnet_1.id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${aws_security_group.rideeasy_sg.id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "rideeasy_1"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.web2.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "sudo apt-get install openjdk-8-jdk -y",
            "sudo apt-get install tomcat8 -y",
            "sudo wget https://satish-s3-from-console.s3.ap-south-1.amazonaws.com/webapp.war",
            "sudo mv webapp.war /var/lib/tomcat8/webapps/"

        ]
    }
}


resource "aws_instance" "web2" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.subnet_2.id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${aws_security_group.rideeasy_sg.id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "rideeasy_2"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.web2.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "sudo apt-get install openjdk-8-jdk -y",
            "sudo apt-get install tomcat8 -y",
            "sudo wget https://satish-s3-from-console.s3.ap-south-1.amazonaws.com/webapp.war",
            "sudo mv webapp.war /var/lib/tomcat8/webapps/"
            
        ]
    }
}


