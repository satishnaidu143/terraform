resource "aws_instance" "web1" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${var.subnet_1_id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${var.sg_id}" ]
    key_name                    = "${var.awskeypair}"
    tags = {
        Name = "rideeasy_1"
    }
   connection {
        type        = "ssh"
        user        = "${var.sshusername}"
        private_key = "${file(var.sshkeypath)}"
        host        = "${aws_instance.web1.public_ip}"
    }

    provisioner "remote-exec" {
        inline  = [
            "sudo apt-get update",
            "sudo apt-get install openjdk-8-jdk -y",
            "sudo apt-get update",
            "sudo apt-get install tomcat8 -y",
            "sudo wget https://satish-s3-from-console.s3.ap-south-1.amazonaws.com/webapp.war",
            "sudo mv webapp.war /var/lib/tomcat8/webapps/"

        ]
    }
}


resource "aws_instance" "web2" {
    ami                         = "${var.appserverami}"
    instance_type               = "t2.micro"
    subnet_id                   = "${var.subnet_2_id}"
    associate_public_ip_address = true
    vpc_security_group_ids      = [ "${var.sg_id}" ]
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
            "sudo apt-get update",
            "sudo apt-get install tomcat8 -y",
            "sudo wget https://satish-s3-from-console.s3.ap-south-1.amazonaws.com/webapp.war",
            "sudo mv webapp.war /var/lib/tomcat8/webapps/"
            
        ]
    }
}


