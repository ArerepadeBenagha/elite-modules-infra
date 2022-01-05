variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}
variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "http_port" {
  type        = string
  description = "Http port for cloudfront."
}

variable "https_port" {
  type        = string
  description = "Https port for cloudfront."
}

variable "origin_protocol_policy" {
  type        = string
  description = "Protocol policy for cloudfront."
}

variable "enabled" {
  type        = string
  description = "custom origin configuration."
}

variable "is_ipv6_enabled" {
  type        = string
  description = "ipv6 configuration."
}

variable "viewer_protocol_policy" {
  type        = string
  description = "viewer protocol policy for cloudfront."
}

variable "ssl" {
  type        = string
  description = "type of supported certificate ssl policy for cloudfront."
}

variable "bucket_appname" {
  type        = string
  description = "name giving to app on s3 bucket."
}

variable "env" {
  type        = string
  description = "Properly choose this environment to fit your need."
}

variable "region" {
  type        = string
  description = "Properly choose this aws region to fit your need."
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