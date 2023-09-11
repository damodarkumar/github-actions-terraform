# use ubuntu 20 AMI for EC2 instance
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/*20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    
    owners = ["099720109477"] # Canonical
}

provider "aws" {
  region  = "eu-north-1"
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.ubuntu.id
  vpc_id                 = "vpc-0a5e26f5c2cf5a8d2"
  instance_type          = "t3.micro"
  key_name               = "githubworkflow-ec2-key"
  

  tags = {
    Name = var.ec2_name
  }
}