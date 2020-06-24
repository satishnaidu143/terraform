output "webserver1-ip" {
value = "${aws_instance.node1.public_ip}"
}
output "webserver2-ip" {
value = "${aws_instance.node2.public_ip}"
}
output "webserver3-ip" {
value = "${aws_instance.node3.public_ip}"
}
output "webserver4-ip" {
value = "${aws_instance.node4.public_ip}"
}
