variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "eu-north-1"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  default     = "labs-test"
}
