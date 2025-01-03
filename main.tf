terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
}

module "my_workerpool" {
  source = "github.com/Daniellem97/autoscaleflag"

  configuration = <<-EOT
    export SPACELIFT_TOKEN="${var.worker_pool_config}"
    export SPACELIFT_POOL_PRIVATE_KEY="${var.worker_pool_private_key}"
    export SPACELIFT_DOCKER_CONFIG_DIR="/home/spacelift/.docker"
  EOT


  autoscaler_version     = "v1.0.1" # Explicitly set the autoscaler version
  min_size               = 1
  max_size               = 3
  worker_pool_id         = var.worker_pool_id
  security_groups        = var.worker_pool_security_groups
  vpc_subnets            = var.worker_pool_subnets
  ec2_instance_type      = "t3.small"
  poweroff_delay         = var.poweroff_delay
  spacelift_api_key_endpoint = var.spacelift_api_key_endpoint
  spacelift_api_key_id   = var.spacelift_api_key_id
  spacelift_api_key_secret = var.spacelift_api_key_secret
}
