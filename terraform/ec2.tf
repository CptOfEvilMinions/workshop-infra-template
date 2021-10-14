############################################ Create test host ###########################################
# Create Security group for test
resource "aws_security_group" "test_pubic_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 	
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_prefix}_TEST_PUBLIC_SG"
    Team = "sec-eng"
    Conference = "2021-Defcon"
  }
}

resource "aws_instance" "test_ec2_instance" {
  ami           			        = var.ubunut-ami
  instance_type 		          = "t3.micro"
  subnet_id 				          = aws_subnet.public_subnet.id
  vpc_security_group_ids 	    = [aws_security_group.test_pubic_sg.id]
  key_name 					          = "${var.project_prefix}-ssh-key"
  # UNcomment this to enable termination protection
  #disable_api_termination     = true
  associate_public_ip_address = true

 	tags = {
  	Name = "${var.project_prefix}_test_box"
    Team = "sec-eng"
    Conference = "2021-Defcon"
 	}
}