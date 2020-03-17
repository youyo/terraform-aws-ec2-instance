output "id" {
  value       = aws_instance.this.id
  description = "The instance ID"
}
output "arn" {
  value       = aws_instance.this.arn
  description = "The ARN of the instance"
}
output "public_dns" {
  value       = aws_instance.this.public_dns
  description = "The public DNS name assigned to the instance"
}
output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "The public IP address assigned to the instance"
}
output "ipv6_addresses" {
  value       = aws_instance.this.ipv6_addresses
  description = "A list of assigned IPv6 addresses, if any"
}
output "primary_network_interface_id" {
  value       = aws_instance.this.primary_network_interface_id
  description = "The ID of the instance's primary network interface"
}
output "private_dns" {
  value       = aws_instance.this.private_dns
  description = "The private DNS name assigned to the instance"
}
output "private_ip" {
  value       = aws_instance.this.private_ip
  description = "The private IP address assigned to the instance"
}
output "instance_state" {
  value       = aws_instance.this.instance_state
  description = "The state of the instance"
}
output "root_block_device_volume_id" {
  value       = aws_instance.this.root_block_device.0.volume_id
  description = "Root block device volume id"
}
