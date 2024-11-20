{"changed":true,"filter":false,"title":"main.tf","tooltip":"/main.tf","value":"terraform {\n  required_providers {\n    aws = {\n      source  = \"hashicorp/aws\"\n      version = \"5.0\"\n    }\n  }\n}\n\n# Configure the AWS Provider\nprovider \"aws\" {\n  region = \"us-east-2\"\n}\n\n\nresource \"aws_instance\" \"Jenkins-EC2\" {\n  ami                         = \"ami-050cd642fd83388e4\"\n  instance_type               = \"t2.micro\"\n  user_data                   = file(\"user-data.sh\")\n  vpc_security_group_ids      = [aws_security_group.ec2_jenkins.id]\n  associate_public_ip_address = true # This allows for the Instance to have a public IP address\n\n  tags = {\n    Name = \"Jenkins-Instance\"\n  }\n}\n#create a security group\nresource \"aws_security_group\" \"ec2_jenkins\" {\n  name        = \"jenkins_sg\"\n  description = \"Security group for SSH and Jenkins\"\n\n  # Allow Jenkins web interface (HTTP/HTTPS) \n  ingress {\n    from_port   = 8080\n    to_port     = 8080\n    protocol    = \"tcp\"\n    cidr_blocks = [\"0.0.0.0/0\"]\n  }\n\n  ingress {\n    from_port   = 22\n    to_port     = 22\n    protocol    = \"tcp\"\n    cidr_blocks = [\"My IP address\"]\n  }\n\n  # Allow all outbound traffic \n  egress {\n    from_port   = 0\n    to_port     = 0\n    protocol    = \"-1\"\n    cidr_blocks = [\"0.0.0.0/0\"]\n  }\n\n  tags = {\n    Name = \"Jenkins EC2 Instance Security Group\"\n  }\n}\nresource \"aws_s3_bucket\" \"jenkins-artifact\" {\n  bucket = \"jenkins-blueserver\"\n\n  tags = {\n    Name        = \"Jenkins-Blueserver\"\n    Environment = \"Dev\"\n  }\n}\nresource \"aws_s3_bucket_public_access_block\" \"jenkins-artifact\" {\n  bucket = aws_s3_bucket.jenkins-artifact.id\n\n  block_public_acls       = true\n  block_public_policy     = true\n  ignore_public_acls      = true\n  restrict_public_buckets = true\n}","undoManager":{"mark":-2,"position":0,"stack":[[{"start":{"row":0,"column":0},"end":{"row":73,"column":1},"action":"insert","lines":["terraform {","  required_providers {","    aws = {","      source  = \"hashicorp/aws\"","      version = \"5.0\"","    }","  }","}","","# Configure the AWS Provider","provider \"aws\" {","  region = \"us-east-2\"","}","","","resource \"aws_instance\" \"Jenkins-EC2\" {","  ami                         = \"ami-050cd642fd83388e4\"","  instance_type               = \"t2.micro\"","  user_data                   = file(\"user-data.sh\")","  vpc_security_group_ids      = [aws_security_group.ec2_jenkins.id]","  associate_public_ip_address = true # This allows for the Instance to have a public IP address","","  tags = {","    Name = \"Jenkins-Instance\"","  }","}","#create a security group","resource \"aws_security_group\" \"ec2_jenkins\" {","  name        = \"jenkins_sg\"","  description = \"Security group for SSH and Jenkins\"","","  # Allow Jenkins web interface (HTTP/HTTPS) ","  ingress {","    from_port   = 8080","    to_port     = 8080","    protocol    = \"tcp\"","    cidr_blocks = [\"0.0.0.0/0\"]","  }","","  ingress {","    from_port   = 22","    to_port     = 22","    protocol    = \"tcp\"","    cidr_blocks = [\"My IP address\"]","  }","","  # Allow all outbound traffic ","  egress {","    from_port   = 0","    to_port     = 0","    protocol    = \"-1\"","    cidr_blocks = [\"0.0.0.0/0\"]","  }","","  tags = {","    Name = \"Jenkins EC2 Instance Security Group\"","  }","}","resource \"aws_s3_bucket\" \"jenkins-artifact\" {","  bucket = \"jenkins-blueserver\"","","  tags = {","    Name        = \"Jenkins-Blueserver\"","    Environment = \"Dev\"","  }","}","resource \"aws_s3_bucket_public_access_block\" \"jenkins-artifact\" {","  bucket = aws_s3_bucket.jenkins-artifact.id","","  block_public_acls       = true","  block_public_policy     = true","  ignore_public_acls      = true","  restrict_public_buckets = true","}"],"id":1}]]},"ace":{"folds":[],"scrolltop":944.7496337890625,"scrollleft":0,"selection":{"start":{"row":73,"column":1},"end":{"row":73,"column":1},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":58,"state":"start","mode":"ace/mode/terraform"}},"timestamp":1732060363977}