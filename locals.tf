locals {
  project = "static-web"
  tags = {
    Env       = title(var.env)
  }
  name = "${var.env}-${local.project}"

}