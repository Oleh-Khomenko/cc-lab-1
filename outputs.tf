output "instance_public_ip" {
  description = "The public IP of the web server instance"
  value       = aws_instance.my-instance.public_ip
}

output "instance_public_dns" {
  description = "The public DNS of the web server instance"
  value       = aws_instance.my-instance.public_dns
}
