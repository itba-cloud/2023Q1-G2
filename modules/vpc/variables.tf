variable "name_prefix" {
  description = "Prefix for Name tag in services"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block of the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "zones_count" {
  description = "Number of zones."
  type        = number
  default     = 2
}
variable "ingress_protocol" {
  type        = number
  description = "Ingress chosen protocol"
}

variable "ingress_self" {
  type        = bool
  description = "Whether ingress to self is permitted or not"
}

variable "ingress_from_port" {
  type        = number
  description = "From port number"
}

variable "ingress_to_port" {
  type        = number
  description = "To port number"
}

variable "egress_from_port" {
  type        = number
  description = "From port number"
}

variable "egress_to_port" {
  type        = number
  description = "To port number"
}

variable "egress_protocol" {
  type        = number
  description = "Egress chosen protocol"
}

variable "egress_cidr" {
  type        = list(any)
  description = "Egress CIDR"
}

variable "sg_tag_name" {
  type        = string
  description = "Security group tag for resource identification"
}
