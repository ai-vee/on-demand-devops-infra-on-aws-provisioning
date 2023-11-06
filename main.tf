terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws",
        version = "~>3.0"
        }
    }
}

# configure aws provider
provider "aws" {
    region = "ap-southeast-2"
}

module "vpc" {
    source = "./modules/vpc-data-center"
    cidr_block = var.cidr_block
    ports = var.ports
    vpc_name_tag = var.vpc_name_tag
    env = var.env
}