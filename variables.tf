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