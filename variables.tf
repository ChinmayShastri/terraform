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
    us-east-1 = "ami-04b3c39a8a1c62b76"
    us-east-2 = "ami-0b76100074ce446d4"
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