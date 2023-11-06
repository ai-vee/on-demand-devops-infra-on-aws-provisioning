variable "cidr_block" {
    type = list(string)
}

variable "ports" {
    type = list(number)
}

variable "vpc_name_tag" {
    type = string
}

variable "env" {
    type = string
}