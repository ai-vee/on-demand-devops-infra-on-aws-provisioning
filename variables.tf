variable "cidr_block" {
    type = list(string)
    default = [ "172.20.0.0/16", "172.20.10.0/24" ]
}

variable "ports" {
    type = list(number)
    default = [ 22, 80, 443, 8080 ]
}

variable "vpc_name_tag" {
    type = string
    default = "devopsinfra"
}

variable "env" {
    type = string
    default = "develop"
}