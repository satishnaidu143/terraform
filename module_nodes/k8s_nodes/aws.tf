resource "aws_instance" "node1" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${var.subnet_1_id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${var.sg_id}" ]
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
            "sudo kubeadm join 10.10.0.6:6443 --token fdcehb.dtzfp2yrmxqdu30c     --discovery-token-ca-cert-hash sha256:e4516a00bd6a76cd88c2bc4f7b2b532dcc31b0eeab689df6945bb5c4ed504b1b"

        ]
    }
}


resource "aws_instance" "node2" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${var.subnet_2_id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${var.sg_id}" ]
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
            "sudo kubeadm join 10.10.0.6:6443 --token fdcehb.dtzfp2yrmxqdu30c     --discovery-token-ca-cert-hash sha256:e4516a00bd6a76cd88c2bc4f7b2b532dcc31b0eeab689df6945bb5c4ed504b1b"
        ]
    }
}

resource "aws_instance" "node3" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${var.subnet_1_id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${var.sg_id}" ]
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
            "sudo kubeadm join 10.10.0.6:6443 --token fdcehb.dtzfp2yrmxqdu30c     --discovery-token-ca-cert-hash sha256:e4516a00bd6a76cd88c2bc4f7b2b532dcc31b0eeab689df6945bb5c4ed504b1b"
        ]
    }
}

resource "aws_instance" "node4" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${var.subnet_2_id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${var.sg_id}" ]
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
            "sudo kubeadm join 10.10.0.6:6443 --token fdcehb.dtzfp2yrmxqdu30c     --discovery-token-ca-cert-hash sha256:e4516a00bd6a76cd88c2bc4f7b2b532dcc31b0eeab689df6945bb5c4ed504b1b"
        ]
    }
}