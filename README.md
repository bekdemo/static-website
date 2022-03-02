# terraform
Terraform code to static website with s3 and cloudfront (for custom specs add different tfvars file.
variables needed domain name, env, hostedzone ID.

```
export AWS_ACCESS_KEY_ID=
export AWX_SECRET_ACCESS_KEY=
terraform apply --var-file=dev.tfvars --auto-approve
```

