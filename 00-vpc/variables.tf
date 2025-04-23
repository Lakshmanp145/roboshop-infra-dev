variable "cidr_block" {
    default = "10.0.0.0/16"

}

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

variable "vpc_tags" {
    default = {
        purpose = "assignment"
    }
}

variable "public_subnet_cidrs" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "is_peering_required" {
    default = true
}