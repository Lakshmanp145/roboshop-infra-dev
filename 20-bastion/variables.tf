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