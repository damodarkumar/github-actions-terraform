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
  instance_type          = "t3.micro"
  key_name               = "githubworkflow-ec2-key"
  vpc_security_group_ids = ["sg-01cab0749958c8eb9", "sg-0bacc34465d34a821"]
  subnet_id              = "subnet-0d057951ed8b3350a"

  tags = {
    Name = var.ec2_name
  }
}