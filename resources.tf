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

data "aws_ami" "centos7mini" {
    most_recent = true
    owners = ["125523088429"]

    filter {
        name ="name"
        values = ["CentOS*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    filter {
        name   = "image-type"
        values = ["machine"]
    }
}

resource "aws_instance" "tf-test-server" {
    ami = data.aws_ami.centos7mini.id
    instance_type = "t2.micro"

    subnet_id = aws_subnet.subnet1.id

    tags = {
        Name = "tf-test-server"
    }
}

