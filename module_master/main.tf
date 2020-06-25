provider "aws" {
   region       = "${var.region}"
   access_key   = "${var.accesskey}"
   secret_key   = "${var.secretkey}"
}

module "k8s_nodes"{
    source = "./k8s_jenkins"
}

