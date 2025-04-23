variable "project" {
    default = "expense"
}

variable "environment" {
    default = "prod"
}

variable "common_tags" {
    default = {
        project = "expense"
        environment = "prod"
        terraform = "true"
    }
}

variable "zone_id" {
    default = "Z0297339GVFSCF3IFANY"
}

variable "domain_name" {
    default = "lakshman.site"
}