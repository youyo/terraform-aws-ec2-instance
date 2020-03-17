# AWS Lambda Terraform module

## Requiirements

- Terraform version > 0.12

## Usage

```hcl
module "ec2-instance" {
  source = "youyo/ec2-instance/aws"

  name                        = "my-instance"
  ami                         = "ami-052652afxxxxxxxxx"
  instance_type               = "t3.micro"
  key_name                    = "my-keypair"
  monitoring                  = true
  subnet_id                   = "subnet-0a80d80dxxxxxxxx"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-0d95004xxxxxxxxxx"]
  ebs_optimized               = true
  enable_eip                  = true
  user_data                   = file("${path.module}/userdata.txt")

  instance_profile_policy  = data.aws_iam_policy_document.this.json
  attach_role_policies_arn = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  role_path                = "/"

  root_block_device_volume_type           = "gp2"
  root_block_device_volume_size           = 10
  root_block_device_delete_on_termination = true

  auto_update_ssm_agent                = true
  update_ssm_agent_schedule_expression = "cron(0 2 ? * SUN *)"

  tags = {
    "Env" = "production"
  }

}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = ["*"]
  }
}
```
