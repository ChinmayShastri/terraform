#Variables definatin for shivay-project

variable "REGION" {
  default = "us-east-2"
}

variable "AMI" {
    type = map
    default = {
        us-east-2 = ami-123
        us-east-1 = ami-321
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "shivay_key_pair"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "shivay_key_pair.pub"
}

variable "INSTANCE_NAME" {
  default = "ec2-user"
}