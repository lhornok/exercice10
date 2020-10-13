##########################################
# MEMCACHED                              #
##########################################

resource "aws_elasticache_cluster" "mademoizelle" {
  cluster_id           = "cluster-mademoizelle"
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.5"
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.mademoizelle.id
  security_group_ids   = [aws_security_group.memcached.id]
}
