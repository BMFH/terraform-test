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

