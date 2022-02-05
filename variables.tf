variable "domain_name" {
  type        = string
  description = "The domain name for the website."
  default     = "elitelabtools.com"
}
variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default     = "elitelabtools.com"
}

variable "http_port" {
  type        = number
  description = "Http port for cloudfront."
  default     = 80
}

variable "https_port" {
  type        = number
  description = "Https port for cloudfront."
  default     = 443
}

variable "origin_protocol_policy" {
  type        = string
  description = "Protocol policy for cloudfront."
  default     = "http-only"
}

variable "enabled" {
  type        = bool
  description = "custom origin configuration."
  default     = true
}

variable "is_ipv6_enabled" {
  type        = bool
  description = "ipv6 configuration."
  default     = true
}

variable "viewer_protocol_policy" {
  type        = string
  description = "viewer protocol policy for cloudfront."
  default     = "redirect-to-https"
}

variable "ssl" {
  type        = string
  description = "type of supported certificate ssl policy for cloudfront."
  default     = "sni-only"
}

variable "bucket_appname" {
  type        = string
  description = "name giving to app on s3 bucket."
  default     = "test-xyz123"
}

variable "env" {
  type        = string
  description = "Properly choose this environment to fit your need."
  default     = "dev"
}

variable "region" {
  type        = string
  description = "Properly choose this aws region to fit your need."
  default     = "us-east-1"
}

variable "validation_method" {
  type        = string
  description = "validation method for DNS."
  default     = "DNS"
}

variable "ssl_name" {
  type        = string
  description = "validation method for DNS."
  default     = "cert-buts"
}

variable "cloudfront" {
  type        = string
  description = "validation method for DNS."
  default     = "test"
}

//vpc
variable "enable_dhcp_options" {
  description = "Enable creation of DHCP Options"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = string
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = string
  default     = false
}

# variable "domain_name" {
#   description = "The suffix domain to use by default when resolving non Full Qualified Domain Names, if left blank then <region>.compute.internal will be used"
#   type        = string
#   default     = ""
# }

variable "domain_name_servers" {
  description = "List of name servers to configure in /etc/resolve.conf, defaults to the default AWS nameservers"
  type        = list(string)

  default = [
    "AmazonProvidedDNS",
  ]
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "tags_for_resource" {
  description = "A nested map of tags to assign to specific resource types"
  type        = map(map(string))
  default     = {}
}

# Public subnet variables

variable "public_propagating_vgws" {
  description = "A list of virtual gateways for route propagation in the public subnets"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Assign a public IP address to instances launched into the public subnets"
  type        = string
  default     = true
}

# variable "availability_zones" {
#   description = "A list of availability zones to create subnets in"
#   type        = list(string)
# }

# variable "private_cidr_block" {
#   description = "The larger CIDR block to use for calculating individual private subnet CIDR blocks"
#   type        = string
# }

# variable "private_subnet_count" {
#   description = "The number of private subnets to create"
#   type        = string
# }

# variable "private_propagating_vgws" {
#   description = "A list of virtual gateways for route propagation in the private subnets"
#   type        = list(string)
#   default     = []
# }

variable "subnet_count" {
  description = "subnet count for network in Vpc"
  type        = number
  default     = 1
}