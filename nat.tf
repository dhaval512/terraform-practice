#net gw
resource "aws_eip" "nat" {
  vpc              = true
  
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-ap-south-1a.id
  #depends_on = aws_internet_gateway.main-gw
}
#VPC for route tabe for private
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
}
  #route associations private
  resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.main-ap-south-1a-private.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "e" {
  subnet_id      = aws_subnet.main-ap-south-1b-private.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "f" {
  subnet_id      = aws_subnet.main-ap-south-1c-private.id
  route_table_id = aws_route_table.main-private.id
}