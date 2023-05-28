terraform {
  backend "s3" {
    bucket = "eks-bucket-backend-terraform"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}