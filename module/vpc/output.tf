output "aws_allow_internet" {
  value = aws_security_group.awsgrp1.id
}
output "aws_sql" {
  value = aws_security_group.awsgrp2.id
}
output "aws_allow_ssh" {
  value = aws_security_group.awsgrp3.id
}
output "aws_only_ssh" {
  value = aws_security_group.awsgrp4.id
}
output "public_ip_id" {
  value = aws_subnet.public-subnet.id
}
output "private_ip_id" {
  value = aws_subnet.private-subnet.id
}
output "public_ip" {
  value = aws_subnet.public-subnet
}
output "private_ip" {
  value = aws_subnet.private-subnet
}
output "aws_internet_gateway" {
value = aws_internet_gateway.internet_gateway 
}
output "aws_nat_gateway" {
value = aws_nat_gateway.nat_gateway
}
output "vpc_1" {
  value = aws_vpc.vpc
}
# output "public" {
#   value = " "
# }