variable "project" {
  type    = string
  default = "gke-dksung"
}

variable "region" {
  type    = string
  default = "asia-northeast3"
}

variable "zone" {
  type    = list(string)
  default = ["asia-northeast3-a", "asia-northeast3-b", "asia-northeast3-c"]
}

variable "env" {
  type    = string
  default = "dev"
}

variable "github" {
  type = string
  default = "github"
}


variable "bastion" {
  type = string
  default = "bastion"
}