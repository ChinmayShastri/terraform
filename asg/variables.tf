variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-123"
    us-east-2 = "ami-321"
  }
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "shivay_pub_key"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "shivay_key"
}

variable "USERNAME" {
  default = "ec2-user"
}
