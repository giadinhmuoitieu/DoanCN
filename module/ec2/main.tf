//WebServer
resource "aws_instance" "webserver" {
  instance_type = var.type
  ami           = var.ami_webserver
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  depends_on = [
    var.aws_internet_gateway
  ]


  tags = {
    Name = "${var.name} Word Press  Webserver"
  }

  vpc_security_group_ids = [var.aws_allow_internet]

}
//SQL
resource "aws_instance" "mysql" {
  depends_on = [
    var.aws_nat_gateway
  ]
  instance_type = var.type
  ami           = var.ami_sql
  key_name      = var.key_name
  subnet_id     = var.private_subnet_id


  tags = {
    Name = "${var.name} MySQl"
  }
  vpc_security_group_ids = [var.aws_sql, var.aws_only_ssh]

}
//Bastion
resource "aws_instance" "Bastion" {
  ami           = var.ami_id
  instance_type = var.type
  subnet_id     = var.public_subnet_id


  key_name = var.key_name

  vpc_security_group_ids = [var.aws_allow_ssh]
  tags = {
    Name = "${var.name} Bastion"
  }
}