output "vpc_id" {
    value = aws_vpc.app.id
}


output "pub_subnets_ids" {
  value = aws_subnet.pub[*].id
}

output "priv_subnets_ids" {
  value = aws_subnet.priv[*].id
}