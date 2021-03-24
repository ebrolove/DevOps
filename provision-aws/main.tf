/*         terraform {
            version = "~> 2.65"
            region  = "us-east-2"

} */



provider "aws" {
  profile = "default"
  region  = "us-west-2"
}


#creating a VPC 
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"


  tags = {
    Name = "tf-ebro_vpc"
  }
}


#creating my subnet inside the above VPC
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "tf-ebro_subnet"
  }
}

#creating a network interface 

resource "aws_network_interface" "NIC_ebro" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}


#get the AMI details to be used for creating the EC2
#note that the AMI gets created using packer and the details are in the packer build file or go to AWS and
#find the details there
data "aws_ami" "AWS_EC2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Ebro_centOS*"]
  }
  owners = ["936441310452"] #my own account number
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.AWS_EC2.id
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.NIC_ebro.id
    device_index         = 0
  }

  tags = {
    Name = "HelloWorld"
  }
}