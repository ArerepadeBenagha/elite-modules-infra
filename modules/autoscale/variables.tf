//required

variable "launch_template" {
  description = "Number of Templates to be launched"
  type        = string
}

variable "name" {
  description = "Name for Launch Template Configuraion"
  type        = string
}

variable "image_id" {
  type        = string
  description = "The EC2 image ID to launch"
  default     = ""
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  description = "Shutdown behavior for the instances. Can be `stop` or `terminate`"
  default     = "terminate"
}


variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"

  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
    })
  }))

  default = []
}

variable "credit_specification" {
  description = "Customize the credit specification of the instances"

  type = object({
    cpu_credits = string
  })

  default = null
}

variable "disable_api_termination" {
  type        = bool
  description = "If `true`, enables EC2 Instance Termination Protection"
  default     = false
}

variable "ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "update_default_version" {
  type        = bool
  description = "Whether to update Default version of Launch template each update"
  default     = false
}

variable "iam_instance_profile_name" {
  type        = string
  description = "The IAM instance profile name to associate with launched instances"
  default     = null
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable/disable detailed monitoring"
  default     = true
}

variable "instance_type" {
  type        = string
  description = "Instance type to launch"
}

variable "key_name" {
  type        = string
  description = "The SSH key name that should be used for the instance"
  default     = null
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Set false to disable the Instance Metadata Service."
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 2
  description = <<-EOT
    The desired HTTP PUT response hop limit (between 1 and 64) for Instance Metadata Service requests.
    The default is `2` to support containerized workloads.
    EOT
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = true
  description = "Set true to require IMDS session tokens, disabling Instance Metadata Service Version 1."
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with an instance in a VPC"
  default     = false
}

variable "security_group_ids" {
  description = "A list of associated security group IDs"
  type        = list(string)
  default     = []
}

variable "placement" {
  description = "The placement specifications of the instances"

  type = object({
    availability_zone = string
  })

  default = null
}

variable "tag_specifications_resource_types" {
  type        = set(string)
  default     = ["instance", "volume"]
  description = "List of tag specification resource types to tag. Valid values are instance, volume, elastic-gpu and spot-instances-request."
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {}
}

variable "user_data_base64" {
  type        = string
  description = "The Base64-encoded user data to provide when launching the instances"
  default     = null
}
