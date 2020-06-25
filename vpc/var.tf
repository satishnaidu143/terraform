variable "accesskey" {
    type = "string"
}

variable "secretkey" {
    type = "string"
}


variable "region" {
    type = "string"
    default = "ap-south-1"
}

variable "subnet1az" {
    type    = "string"
    default = "ap-south-1a"
}


variable "subnet2az" {
    type    = "string"
    default = "ap-south-1b"
}