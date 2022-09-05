provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "saiterraform"
    key    = "Terraform_Fucntions"
    region = "us-east-1"
  }
}
resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name       = "${var.vpc_name}"
    deployedby = local.deployedby
    Owner      = local.Owner
    costcenter = local.costcenter
    teamdl     = local.teamdl
    environmet = "${var.environment}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

resource "aws_subnet" "subnet-public" {
  count             = length(var.public_cidr_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name       = "${var.vpc_name}-Public-subnet ${count.index + 1}"
    deployedby = local.deployedby
    Owner      = local.Owner
    costcenter = local.costcenter
    teamdl     = local.teamdl
    environmet = "${var.environment}"
  }
}

resource "aws_subnet" "subnet-private" {
  count             = length(var.private_cidr_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name       = "${var.vpc_name}-private-subnet ${count.index + 1}"
    deployedby = local.deployedby
    Owner      = local.Owner
    costcenter = local.costcenter
    teamdl     = local.teamdl
    environmet = "${var.environment}"
  }
}

resource "aws_route_table" "public-routing-table" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name       = "${var.vpc_name}-public-RT"
    deployedby = local.deployedby
    Owner      = local.Owner
    costcenter = local.costcenter
    teamdl     = local.teamdl
    environmet = "${var.environment}"
  }
}


resource "aws_route_table" "private-routing-table" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name       = "${var.vpc_name}-private-RT"
    deployedby = local.deployedby
    Owner      = local.Owner
    costcenter = local.costcenter
    teamdl     = local.teamdl
    environmet = "${var.environment}"
  }
}

resource "aws_route_table_association" "public-subnets" {
  count          = length(var.public_cidr_block)
  subnet_id      = element(aws_subnet.subnet-public.*.id, count.index)
  route_table_id = aws_route_table.public-routing-table.id
}

resource "aws_route_table_association" "private-subnets" {
  count          = length(var.public_cidr_block)
  subnet_id      = element(aws_subnet.subnet-private.*.id, count.index)
  route_table_id = aws_route_table.private-routing-table.id
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# data "aws_ami" "my_ami" {
#      most_recent      = true
#      #name_regex       = "^mavrick"
#      owners           = ["721834156908"]
# }

##output "ami_id" {
#  value = "${data.aws_ami.my_ami.id}"
#}
#!/bin/bash
# echo "Listing the files in the repo."
# ls -al
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Packer Now...!!"
# packer build -var=aws_access_key=AAAAAAAAAAAAAAAAAA -var=aws_secret_key=BBBBBBBBBBBBB packer.json
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Terraform Now...!!"
# terraform init
# terraform apply --var-file terraform.tfvars -var="aws_access_key=AAAAAAAAAAAAAAAAAA" -var="aws_secret_key=BBBBBBBBBBBBB" --auto-approve
