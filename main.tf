# Terraform multi-region configuration

provider "aws" {
  alias  = "east_region"
  region = "us-east-1"
}

provider "aws" {
  alias  = "west_region"
  region = "us-west-2"
}

# S3 bucket creation 

resource "random_id" "bucket_east" {
  byte_length = 4
}

resource "aws_s3_bucket" "terraform_project_multi_region_east" {
  bucket   = "my-multi-region-bucket-east-${random_id.bucket_east.hex}"
  provider = aws.east_region
}

# Create ec2 instance_type

resource "aws_instance" "multi_region_1" {
    ami = "ami-0236922087fa98b6e"
    instance_type = "t2.micro"
    provider = aws.east_region
    tags = {
        Name = "east_ec2"
        Env = "prod"
    }
}

resource "aws_instance" "multi_region_2" {
    ami = "ami-00563078bca04e287"
    instance_type = "t2.micro"
    provider = aws.west_region
    tags = {
        Name = "west_ec2"
    }
}