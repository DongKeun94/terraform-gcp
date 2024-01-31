variable "project" {
  type    = string
  default = "gke-dksung"
}

variable "region" {
  type    = string
  default = ""
}

variable "zone" {
  type    = list(string)
  default = ["asia-northeast3-a", "asia-northeast3-b", "asia-northeast3-c"]
}

variable "env" {
  type    = string
  default = "dev"
}