variable "access_key" {}

variable "secret_key" {}

variable "aws_region" {
  description = "The AWS region for the ec2 instance"
  default     = "us-east-2"
}
variable "key_name" {
  description = "Key pair to connect the instance"
  default     = "ubuntuawskey"
}

variable "instance_type" {
  description = "ec2 instance type"
  default     = "t2.micro"
}

variable "bucket_prefix" {
    type        = string
    description = "(required since we are not using 'bucket') Creates a unique bucket name beginning with the specified prefix"
    default     = "terraformbucket-"
}

variable "tags" {
    type        = map
    description = "bucket tag"
    default     = {
        environment = "DEV"
        terraform   = "true"
    }
}
variable "versioning" {
    type        = bool
    description = "bucket versioning."
    default     = true
}
variable "acl" {
    type        = string
    description = " Defaults to private "
    default     = "private"
}
