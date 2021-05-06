resource "aws_route_table" "public" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "poc_terraform_eks_public_route_table"
  }
}


resource "aws_route_table" "private1" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw1.id

  }
  tags = {
    Name = "poc_terraform_eks_private1_route_table_us-west-2a"
  }

}


resource "aws_route_table" "private2" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw2.id

  }
  tags = {
    Name = "poc_terraform_eks_private2_route_table_us-west-2b"
  }

}
