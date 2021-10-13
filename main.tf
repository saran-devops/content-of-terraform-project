#Passing provider information,instance region to spun up, alias name for instance

provider "aws" {
  region     = var.aws_region
  alias      = "Jenkins-instance"
  access_key = "AKIASAA4UFYR7MTQCCNP"
  secret_key = "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"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


#Create security group with firewall rules
resource "aws_security_group" "Jenkins_port_config" {
  name        = "Jenkins_port_config"
  description = "Security group for jenkins"
  vpc_id      = aws_default_vpc.main.id

  #Create SG for allowing TCP/8080 from * and TCP/22
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.main.cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "Terraform_Jenkins_instance_security"
    instance_name = "Jenkins_server"
  }
}

resource "aws_default_vpc" "main" {
  tags = {
    Name = "main"
  }
}

#Create Ec2 instance with the declared instance type and keypair

resource "aws_instance" "ec2instance" {
  ami             = data.aws_ami.ubuntu.id
  key_name        = var.key_name
  instance_type   = var.instance_type
  security_groups = [aws_security_group.Jenkins_port_config.name]
  tags = {
    Name = "Jenkins_server"
  }
}

#Create Elastic IP address for instance
resource "aws_eip" "ec2instance" {
  vpc      = true
  instance = aws_instance.ec2instance.id
  tags = {
    Name = "Jenkins_ip"
  }
}
