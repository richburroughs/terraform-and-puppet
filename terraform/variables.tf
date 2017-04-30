variable "pe_version" {
  default = "2017.1.0"
}

variable "console_admin_password" {
  default = "puppetftw"
}

variable "image" {
  default = "centos_7_updated_20170406"
}

variable "flavor" {
  default = "m1.medium"
}

variable "lb_flavor" {
  default = "g1.small"
}

variable "key_pair" {
  default = "rich-gw"
}

variable "private_key" {
  default = "/home/centos/.ssh/id_rsa"
}

variable "network_name" {
  default = "network1"
}

variable "fip_pool" {
  default = "ext-net-pdx1-opdx1"
}

variable "security_groups" {
  default = ["default", "sg0"]
}
