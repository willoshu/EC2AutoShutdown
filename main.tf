terraform {
  /* Uncomment this block to use Terraform Cloud
  cloud {
    organization = "organization-name"
    workspaces {
      name = "EC2AutoShutdown"
    }
  }
  */
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
