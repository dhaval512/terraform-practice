resource "aws_instance" "dhaval" {
  ami = "ami-09052aa9bc337c78d"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-ap-south-1a.id
}