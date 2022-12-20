variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 443,80, 8080]
}
