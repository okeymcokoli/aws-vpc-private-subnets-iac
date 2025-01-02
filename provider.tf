terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Try specifying an older stable version, like 4.0
    }
  }
}