resource "aws_vpc" "app" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC session 4"
  }
}

resource "aws_subnet" "pub" {
  count = length(var.pub_subents)
  vpc_id     = aws_vpc.app.id
  cidr_block = var.pub_subents[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "app-public-subnet${count.index}"
  }
}

resource "aws_subnet" "priv" {
  count = length(var.priv_subents)
  vpc_id     = aws_vpc.app.id
  cidr_block = var.priv_subents[count.index]
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name = "app-private-subnet${count.index}"
  }
}

