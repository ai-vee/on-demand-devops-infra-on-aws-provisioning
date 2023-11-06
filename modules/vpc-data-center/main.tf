# inherit aws provider from root

# create a VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block[0]
    tags = {
        Name = "${var.vpc_name_tag}-vpc"
    }
}

# create subnet (public)
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.cidr_block[1] #256 IPs in this subnet
    tags = {
        Name = "${var.vpc_name_tag}-subnet1"
        Environment = var.env
    }
}


resource "aws_internet_gateway" "intgateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.vpc_name_tag}-internet-gateway"
        Environment = var.env
    }
}

resource "aws_security_group" "security-group" {
    name = "DevOps Infra Security Group"
    description = "To control inbound and outbound traffic to the VPC"
    vpc_id = aws_vpc.vpc.id 

    # inbound
    dynamic ingress {
        iterator = port
        for_each = var.ports
            content {
                # allow all ip addresses on port accepted port with required key
                from_port = port.value
                to_port = port.value
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            }
    }

    # outbound
    egress {
        # talk to any server on any port
        from_port = 0
        to_port = 0
        protocol = "-1" # all protocols
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.vpc_name_tag}-security-group"
        Environment = var.env
    }

}
