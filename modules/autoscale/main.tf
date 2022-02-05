resource "aws_launch_template" "this" {
  count = var.launch_template ? 1 : 0
  name  = var.name

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = lookup(block_device_mappings.value, "ebs", null) == null ? [] : ["ebs"]
        content {
          delete_on_termination = lookup(block_device_mappings.value.ebs, "delete_on_termination", null)
          encrypted             = lookup(block_device_mappings.value.ebs, "encrypted", null)
          iops                  = lookup(block_device_mappings.value.ebs, "iops", null)
          kms_key_id            = lookup(block_device_mappings.value.ebs, "kms_key_id", null)
          snapshot_id           = lookup(block_device_mappings.value.ebs, "snapshot_id", null)
          volume_size           = lookup(block_device_mappings.value.ebs, "volume_size", null)
          volume_type           = lookup(block_device_mappings.value.ebs, "volume_type", null)
        }
      }
    }
  }

  dynamic "credit_specification" {
    for_each = var.credit_specification != null ? [var.credit_specification] : []
    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized
  update_default_version  = var.update_default_version


  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile_name != "" ? [var.iam_instance_profile_name] : []
    content {
      name = iam_instance_profile.value
    }
  }

  image_id                             = var.image_id
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  instance_type = var.instance_type
  key_name      = var.key_name

  metadata_options {
    http_endpoint               = (var.metadata_http_endpoint_enabled) ? "enabled" : "disabled"
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = (var.metadata_http_tokens_required) ? "required" : "optional"
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = var.associate_public_ip_address
    delete_on_termination       = true
    security_groups             = var.security_group_ids
  }

  dynamic "placement" {
    for_each = var.placement != null ? [var.placement] : []
    content {
      availability_zone = lookup(placement.value, "availability_zone", null)

    }
  }

  dynamic "tag_specifications" {
    for_each = var.tag_specifications_resource_types

    content {
      resource_type = tag_specifications.value
      tags          = var.tags
    }
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }

  user_data = var.user_data_base64
}