# Standard Variables

variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "aws_profile" {
  description = "Local AWS Profile Name "
  type        = string
}

variable "environment" {
  description = "AWS Environment"
  type        = string
}

variable "application" {
  type    = string
  default = "jokes"
}

# VPC Variables

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Private subnet  - CIDR"
  type        = string
}

variable "ssh_key_private" {
  description = "SSH private key file"
  type        = string
}
