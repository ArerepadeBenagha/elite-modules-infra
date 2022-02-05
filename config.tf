terraform {
  required_version = ">=0.12"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "default"
}