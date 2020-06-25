resource "aws_instance" "master" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.large"
    subnet_id                   = "${var.subnet_1_id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${var.sg_id}" ]
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

