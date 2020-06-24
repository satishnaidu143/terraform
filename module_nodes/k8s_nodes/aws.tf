resource "aws_vpc" "my_network" {
    cidr_block              = "10.10.0.0/16"
    enable_dns_hostnames    = true
    tags = {
        Name = "tools"
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

resource "aws_instance" "node1" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.subnet_1.id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${aws_security_group.my_sg.id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "node1"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.node1.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "git clone https://github.com/satishnaidu143/install.git",
            "sudo sh install/kube.sh",
            "sudo kubeadm join 10.10.0.198:6443 --token zktx1o.h36yzo95puh8vdol --discovery-token-ca-cert-hash sha256:e50a53f78695b66076e80ea83cc576722af459ca4c0f94e33ee691e24dfef541"
        ]
    }
}


resource "aws_instance" "node2" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.subnet_2.id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${aws_security_group.my_sg.id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "node2"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.node2.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "git clone https://github.com/satishnaidu143/install.git",
            "sudo sh install/kube.sh",
            "sudo kubeadm join 10.10.0.198:6443 --token zktx1o.h36yzo95puh8vdol --discovery-token-ca-cert-hash sha256:e50a53f78695b66076e80ea83cc576722af459ca4c0f94e33ee691e24dfef541"
        ]
    }
}

resource "aws_instance" "node3" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.subnet_1.id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${aws_security_group.my_sg.id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "node3"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.node3.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "git clone https://github.com/satishnaidu143/install.git",
            "sudo sh install/kube.sh",
            "sudo kubeadm join 10.10.0.198:6443 --token zktx1o.h36yzo95puh8vdol --discovery-token-ca-cert-hash sha256:e50a53f78695b66076e80ea83cc576722af459ca4c0f94e33ee691e24dfef541"
        ]
    }
}

resource "aws_instance" "node4" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.subnet_2.id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${aws_security_group.my_sg.id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "node4"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.node4.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "git clone https://github.com/satishnaidu143/install.git",
            "sudo sh install/kube.sh",
            "sudo kubeadm join 10.10.0.198:6443 --token zktx1o.h36yzo95puh8vdol --discovery-token-ca-cert-hash sha256:e50a53f78695b66076e80ea83cc576722af459ca4c0f94e33ee691e24dfef541"
        ]
    }
}