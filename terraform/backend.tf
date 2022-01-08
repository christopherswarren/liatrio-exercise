terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "csw-liatrio-exercise"

    workspaces {
      name = "liatrio-exercise"
    }
  }
}