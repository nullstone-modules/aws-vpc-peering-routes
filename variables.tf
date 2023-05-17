variable "peering_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC peering connection. Example: `pcx-051deccf7afc2ab03`. Leave empty to disable."
}

locals {
  has_peering_id = length(var.peering_id) > 0
}
