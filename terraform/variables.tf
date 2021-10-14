variable "project_prefix" {
  description = "Prefix to prepend to all resources created by this Terraform"
  type    = string
  default = "2021-DEFCON"
}

variable "primary_region" {
  description = "Primary region to create resources in"
  type    = string
  # Ohio
  default = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type    = string
  # Ohio
  default = "172.16.0.0/16"
}

variable "ubunut-ami" {
  description = "Ubuntu AMI image to use for VMs"
  type    = string
  # Ubuntu 20.04
  # https://cloud-images.ubuntu.com/locator/ec2/
  default = "ami-00399ec92321828f5"
}

#### Add SSH keys ####
# https://www.bogotobogo.com/DevOps/Terraform/Terraform-parameters-variables.php
resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_prefix}-ssh-key"
  public_key = file("ssh_keys/id_rsa.pub")
}