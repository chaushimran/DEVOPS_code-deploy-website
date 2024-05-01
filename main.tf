terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-1"
}

resource "aws_s3_bucket" "ichaush_artifacts_devops" {
  bucket = "ichaush-artifacts-devops"
  acl    = "private"  # Set ACL to private by default
}

resource "aws_s3_bucket" "ichaush_destination_devops" {
  bucket = "ichaush-destination-devops"
  acl    = "public-read"  # Allow public read access to the bucket

  website {
    index_document = "index.html"  # Specify the index document for the static website
    error_document = "error.html"  # Specify the error document for the static website
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::ichaush-destination-devops/*"
      ]
    }
  ]
}
EOF
}
