terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}


resource "aws_instance" "Jenkins-EC2" {
  ami                         = "ami-050cd642fd83388e4"
  instance_type               = "t2.micro"
  user_data                   = file("user-data.sh")
  vpc_security_group_ids      = [aws_security_group.ec2_jenkins.id]
  associate_public_ip_address = true # This allows for the Instance to have a public IP address

  tags = {
    Name = "Jenkins-Instance"
  }
}
#create a security group
resource "aws_security_group" "ec2_jenkins" {
  name        = "jenkins_sg"
  description = "Security group for SSH and Jenkins"

  # Allow Jenkins web interface (HTTP/HTTPS) 
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["My IP address"]
  }

  # Allow all outbound traffic 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins EC2 Instance Security Group"
  }
}
resource "aws_s3_bucket" "jenkins-artifact" {
  bucket = "jenkins-blueserver"

  tags = {
    Name        = "Jenkins-Blueserver"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_public_access_block" "jenkins-artifact" {
  bucket = aws_s3_bucket.jenkins-artifact.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}