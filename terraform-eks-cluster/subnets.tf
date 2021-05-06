# Resource: aws_subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public_1" {
  # The VPC ID.
  vpc_id = aws_vpc.vpc.id
  # The CIDR block for the subnet.
  cidr_block = "10.0.0.0/24"
  # The AZ for the subnet.
  availability_zone = "us-west-2a"
  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true
  # A map of tags to assign to the resource.
  tags = {
    Name                        = "poc_terraform_eks_public_subnet_us-west-2a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}


resource "aws_subnet" "public_2" {
  # The VPC ID.
  vpc_id = aws_vpc.vpc.id
  # The CIDR block for the subnet.
  cidr_block = "10.0.4.0/24"
  # The AZ for the subnet.
  availability_zone = "us-west-2b"
  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true
  # A map of tags to assign to the resource.
  tags = {
    Name                        = "poc_terraform_eks_public_subnet_us-west-2b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "private_1" {
  # The VPC ID
  vpc_id = aws_vpc.vpc.id
  # The CIDR block for the subnet.
  cidr_block = "10.0.8.0/24"
  # The AZ for the subnet.
  availability_zone = "us-west-2a"
  # A map of tags to assign to the resource.
  tags = {
    Name                              = "poc_terraform_eks_private_subnet_us-west-2a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}


resource "aws_subnet" "private_2" {
  # The VPC ID
  vpc_id = aws_vpc.vpc.id
  # The CIDR block for the subnet.
  cidr_block = "10.0.12.0/24"
  # The AZ for the subnet.
  availability_zone = "us-west-2b"
  # A map of tags to assign to the resource.
  tags = {
    Name                              = "poc_terraform_eks_private_subnet_us-west-2b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
