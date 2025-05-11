output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

# output "redis_endpoints" {
#   value = aws_elasticache_cluster.redis.configuration_endpoint
# }
output "redis_endpoints2" {
  value=aws_elasticache_cluster.redis.configuration_endpoint
}
