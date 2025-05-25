This module creates an S3 bucket for application assets.

## Usage
```hcl
module "s3" {
  source      = "./modules/storage/s3"
  bucket_name = "my-app-assets"
}

