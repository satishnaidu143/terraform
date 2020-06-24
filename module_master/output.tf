output "webserver1-ip" {
value = "${aws_instance.master.public_ip}"
}

