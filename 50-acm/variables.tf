variable "project_name" {
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

variable "backend_tags" {
    default = {}
}

variable "domain_name" {
    default = "lakshman.site"
}

variable "zone_id" {
    default = "Z0297339GVFSCF3IFANY"
}