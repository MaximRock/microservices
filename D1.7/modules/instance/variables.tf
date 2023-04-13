variable "innstance_family_image" {
  description = "Instance image"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "manager" {
  description = "Manager nodes count"
  type        = number
  default     = 1
}

variable "worker" {
  description = "Worker nodes count"
  type        = number
  default     = 1
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}