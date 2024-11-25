# Description: This file is used to change the vCPU quota for a specific AWS service.
# The default values are for a 3 nodes cluster i4i.metal EC2 instance with 128 vCPUs each.


# /!\ This code is PROVIDED AS IS without any official support of Nutanix /!\
# It can be used if you don't want to create CF Stack and prefer to use Terraform to deploy the roles and permissions
#

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.8"
}



variable "aws-quota-code" {
  description = "The quota code for the service quota."
  type        = string
  default     = "L-1216C47A"  # this is the quota code for Running On-Demand Standard (A, C, D, H, I, M, R, T, Z) instances
}

variable "aws-service-code" {
  description = "The service code for the service quota."
  type        = string
  default     = "ec2" 
}

variable "aws-vcpu-quota" {
  description = "The new vCPU quota value."
  type        = number
  default     = 384    # this is for a 3 nodes cluster i4i with 128 vCPUs each
}


# Create a new vCPU quota for the service quota.
# cf. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicequotas_service_quota.html 
resource "aws_servicequotas_service_quota" "Terra_service_quota_NC2" {
  quota_code   = var.aws-quota-code
  service_code = var.aws-service-code
  value        = var.aws-vcpu-quota
}