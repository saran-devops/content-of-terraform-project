variable "aws_region" {
  description = "The AWS region for the ec2 instance"
  default     = "us-east-2"
}
variable "key_name" {
  description = "Key pair to connect the instance"
  default     = "ubuntukey"
}

variable "instance_type" {
  description = "ec2 instance type"
  default     = "t2.micro"

}
