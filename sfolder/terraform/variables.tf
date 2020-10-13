variable "region" {
  type        = string
  description = "Region where we will create our resources"
  default     = "eu-west-1"
}

#Availability zones
variable "azs" {
  type        = list(string)
  description = "Availability zones"
  default     = ["eu-west-1a", "eu-west-1b"]
}
