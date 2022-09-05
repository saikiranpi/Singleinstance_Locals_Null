aws_region         = "us-east-1"
vpc_cidr           = "172.18.0.0/16"
vpc_name           = "T-Functions"
key_name           = "LaptopKey"
azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_cidr_block  = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
private_cidr_block = ["172.18.10.0/24", "172.18.20.0/24", "172.18.30.0/24"]
environment        = "Prod"
amis = {
  us-east-1 = "ami-08d4ac5b634553e16" # ubuntu 20.04 LTS
  us-east-2 = "ami-02f3416038bdb17fb" # ubuntu 22.04 LTS
}
