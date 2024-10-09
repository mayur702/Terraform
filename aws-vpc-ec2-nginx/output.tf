output "instance_public_ip" {
  description = "The Public IP address of the Ec2 instance"
  value = aws_instance.NginxServer.public_ip
}
output "instance_url" {
  description = "The URL to access the Nginx server"
  value = "http://${aws_instance.NginxServer.public_ip}"
}