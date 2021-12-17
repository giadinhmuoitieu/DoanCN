output "publicip" {
  value       = aws_instance.webserver.*.public_ip
  description = "wordpress ip"
}
output "privateip" {
  value       = aws_instance.mysql.*.public_ip
  description = "mysql"

}
