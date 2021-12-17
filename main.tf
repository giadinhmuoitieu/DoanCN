provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


module "server" {
  source               = "./module/ec2"
  ami_id               = var.ami_id
  ami_sql=var.ami_sql
  ami_webserver = var.ami_webserver
  type                 = var.type
  name                 = var.name
  key_name             = var.key_name
  public_subnet_id     = module.vpc.public_ip_id
  private_subnet_id    = module.vpc.private_ip_id
  aws_allow_internet   = module.vpc.aws_allow_internet
  aws_allow_ssh        = module.vpc.aws_allow_ssh
  aws_only_ssh         = module.vpc.aws_only_ssh
  aws_sql              = module.vpc.aws_sql
  vpc                  = module.vpc.vpc_1
  public_subnet        = module.vpc.public_ip
  private_subnet       = module.vpc.private_ip
  aws_internet_gateway = module.vpc.aws_internet_gateway
  aws_nat_gateway = module.vpc.aws_nat_gateway

}

module "vpc" {
  source        = "./module/vpc"
  cird_block    = var.cird_block
  cird_private  = var.cird_private
  cird_public   = var.cird_public
  name          = var.name
  azone_private = var.azone_private
  azone_public  = var.azone_public

}
module "bucket" {
  source = "./module/bucket"
  # namebuck = var.namebuck
  region = var.region

}
