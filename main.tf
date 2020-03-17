resource "aws_instance" "this" {
  ami                         = length(var.ami) > 0 ? var.ami : data.aws_ami.amazonlinux2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.vpc_security_group_ids
  user_data                   = var.user_data
  iam_instance_profile        = aws_iam_instance_profile.this.name
  ebs_optimized               = var.ebs_optimized
  key_name                    = var.key_name
  monitoring                  = var.monitoring

  root_block_device {
    volume_type           = var.root_block_device_volume_type
    volume_size           = var.root_block_device_volume_size
    delete_on_termination = var.root_block_device_delete_on_termination
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

  volume_tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_eip" "this" {
  count = var.enable_eip ? 1 : 0

  vpc      = true
  instance = aws_instance.this.id

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "this" {
  name_prefix        = "${var.name}-"
  path               = var.role_path
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.attach_role_policies_arn)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "this" {
  count = length(var.instance_profile_policy) > 0 ? 1 : 0

  name_prefix = "${var.name}-"
  role        = aws_iam_role.this.name
  policy      = var.instance_profile_policy
}

resource "aws_iam_instance_profile" "this" {
  name_prefix = "${var.name}-"
  path        = var.role_path
  role        = aws_iam_role.this.name
}

resource "aws_ssm_association" "update_ssm_agent" {
  count = var.auto_update_ssm_agent ? 1 : 0

  name = "AWS-UpdateSSMAgent"

  targets {
    key    = "InstanceIds"
    values = [aws_instance.this.id]
  }

  schedule_expression = var.update_ssm_agent_schedule_expression
}
