variable "name" {
  type        = string
  default     = "my-instance"
  description = "A name for your ec2 instance"
}
variable "ami" {
  type        = string
  default     = ""
  description = "The AMI to use for the instance. Default value is latest Amazon Linux 2 AMI ID"
}
variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "The type of instance to start"
}
variable "key_name" {
  type        = string
  default     = ""
  description = "The key name of the Key Pair to use for the instance"
}
variable "monitoring" {
  type        = bool
  default     = true
  description = "EC2 instance will have detailed monitoring enabled"
}
variable "subnet_id" {
  type        = string
  default     = ""
  description = "The VPC Subnet ID to launch in"
}
variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Associate a public ip address with an instance in a VPC"
}
variable "vpc_security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of security group IDs to associate with"
}
variable "ebs_optimized" {
  type        = bool
  default     = true
  description = ""
}
variable "root_block_device_volume_type" {
  type        = string
  default     = "gp2"
  description = ""
}
variable "root_block_device_volume_size" {
  type        = number
  default     = 10
  description = ""
}
variable "root_block_device_delete_on_termination" {
  type        = bool
  default     = true
  description = ""
}
variable "instance_profile_policy" {
  type        = string
  default     = ""
  description = "The IAM Instance Profile Policy to launch the instance with"
}
variable "enable_eip" {
  type        = bool
  default     = false
  description = "Enable EIP"
}
variable "attach_role_policies_arn" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  description = "Attach to instance profile policies"
}
variable "auto_update_ssm_agent" {
  type        = bool
  default     = true
  description = "Auto update SSM Agent"
}
variable "user_data" {
  type        = string
  default     = ""
  description = "The user data to provide when launching the instance"
}
variable "role_path" {
  type        = string
  default     = "/"
  description = "The path to the lambda iam role"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource"
}
variable "update_ssm_agent_schedule_expression" {
  type        = string
  default     = "cron(0 2 ? * SUN *)"
  description = "A cron expression when the association will be applied to the target"
}
