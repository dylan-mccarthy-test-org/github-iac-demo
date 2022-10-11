terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.13.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "dylanmccarthy"
    workspaces {
      name = "github-iac-demo-2"
    }
  }

  required_version = ">= 1.0.5"
}
