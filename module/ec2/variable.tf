variable "ami_id" {
  type = string
}
variable "ami_webserver" {
  type = string
}
variable "ami_sql" {
  type = string
}
variable "type" {
  type = string
}
variable "name" {
  type = string
}
variable "key_name" {
  type = string
}

variable "aws_allow_internet" {
  type = any
}
variable "aws_sql" {
  type = any
}
variable "aws_allow_ssh" {
  type = any
}
variable "aws_only_ssh" {
  type = any
}
variable "vpc" {
  type = any
}
variable "public_subnet_id" {
  type = any
}
variable "private_subnet_id" {
  type = any
}
variable "public_subnet" {
  type = any
}
variable "private_subnet" {
  type = any
}
variable "aws_internet_gateway" {
  type = any
}
variable "aws_nat_gateway" {
  type = any

}