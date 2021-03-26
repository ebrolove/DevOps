variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance-type" {
  type    = string
  default = "t3.micro"
  #  validation {
  #    condition     = can(regex("[^t2]", var.instance-type))
  #    error_message = "Instance type cannot be anything other than t2 or t3 type and also not t3a.micro."
  #  }
}

variable "dns-name" {
  type    = string
  default = "cmcloudlab1803.info." # e.g "cmcloudlab1234.info."
}

variable "profile" {
  type    = string
  default = "default"  # Meaning the default AWS profile from the OS will be used to access the AWS account
}

variable "region-master" {
  type    = string
  default = "us-east-1"
}

variable "region-worker" {
  type    = string
  default = "us-west-2"
}

#How many Jenkins workers to spin up
variable "workers-count" {
  type    = number
  default = 2
}
