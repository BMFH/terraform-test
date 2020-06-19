resource "aws_vpc" "tf-vpc-1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "tf-vpc-1"
    }
}

resource "aws_subnet" "subnet1" {
    cidr_block = cidrsubnet(aws_vpc.tf-vpc-1.cidr_block, 4,1)
    vpc_id = aws_vpc.tf-vpc-1.id
    availability_zone = "eu-central-1a"
}

resource "aws_subnet" "subnet2" {
    cidr_block = cidrsubnet(aws_vpc.tf-vpc-1.cidr_block, 4,2)
    vpc_id = aws_vpc.tf-vpc-1.id
    availability_zone = "eu-central-1b"
}

resource "aws_security_group" "tf-subnet-sg" {
    name = "tf-subnet-sg"
    vpc_id = aws_vpc.tf-vpc-1.id

    ingress {
        description = "for http traffic to subnet vpc1"
        cidr_blocks = [aws_vpc.tf-vpc-1.cidr_block]
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "tf-subnet-sg-name"
    }
}