output "vpc-id" {
value = "${aws_vpc.my_network.id}"
}
output "subnet_1_id" {
value = "${aws_subnet.subnet_1.id}"
}
output "subnet_2_id" {
value = "${aws_subnet.subnet_2.id}"
}
output "rt_id" {
value = "${aws_route_table.my_rt.id}"
}
output "sg_id" {
value = "${aws_security_group.my_sg.id}"
}
output "igw_id" {
value = "${aws_internet_gateway.my_igw.id}"
}