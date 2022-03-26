# AWS verion 4.6.0 giving error for network interface device index, so using 4.5 or greater but not 4.6

terraform {
  required_providers {
    aws = {
      version = "~> 4.5, != 4.6.0"
    }
  }
}