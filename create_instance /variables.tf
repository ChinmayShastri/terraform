variable "AWS_ACCESS_KEY" {
type = string
default = "AKIASQ3STGQZGXHTMX42"  
}

variable "AWS_SECRET_KEY" {
}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-0b0ea68c435eb488d"
    us-east-2 = "ami-05803413c51f242b7"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "ec2key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "ec2key.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}