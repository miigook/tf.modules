variable "app-vpc" {
    type = string
} 

variable "app-subnets-pub" {
   type = set(string)
}

variable "app-subnets-priv" {
   type = set(string)
}

