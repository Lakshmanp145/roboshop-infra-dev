variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
}

variable "domain_name" {
    default = "lakshman.site"
}


variable "zone_id" {
    default = "Z0297339GVFSCF3IFANY"
}