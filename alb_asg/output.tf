output "alb-dns" {
  value = aws_lb.app-lb.dns_name
  
}
output "alb_zone_id" {
  value = aws_lb.app-lb.zone_id
}