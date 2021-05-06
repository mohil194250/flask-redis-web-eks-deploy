# Resource: aws_eip
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "nat1" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "poc_terraform_eks_eip_addr_nat1_us-west-2a"
  }
}

resource "aws_eip" "nat2" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "poc_terraform_eks_eip_addr_nat2_us-west-2b"
  }
}
