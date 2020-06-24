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
