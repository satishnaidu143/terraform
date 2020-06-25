variable "subnet1az" {
    type    = "string"
    default = "ap-south-1a"
}


variable "subnet2az" {
    type    = "string"
    default = "ap-south-1b"
}

variable "appserverami" {
    type    = "string"
    default = "ami-02d55cb47e83a99a0"
  
}

variable "vpc-id" {
    type    = "string"
    default = "vpc-05d68bb1d1bdcbc09"
}

variable "subnet_1_id" {
    type    = "string"
    default = "subnet-041b81627c921b69c"
}

variable "subnet_2_id" {
    type    = "string"
    default = "subnet-0e26d0f9cc883c828"
}

variable "sg_id" {
    type    = "string"
    default = "sg-04ee091295e72ae20"
}

variable "rt_id" {
    type    = "string"
    default = "rtb-020b0d0804c9f422a"
}

variable "igw_id" {
    type    = "string"
    default = "igw-02f58a5dae23623c1"
}

variable "awskeypair" {
    type    = "string"
    default = "terraform"
  
}

variable "sshusername" {
    type    = "string"
    default = "ubuntu"
  
}

variable "sshkeypath" {
    type    = "string"
    default = "./terraform.pem"
  
}