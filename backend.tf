terraform {
  backend "s3" {
    bucket = "terraform-remote-backend"
    key    = "static-web/terraform.tfstate"
    region = "us-east-1"
  }
}