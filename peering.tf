data "aws_vpc_peering_connection" "this" {
  id    = var.peering_id
  count = local.has_peering_id ? 1 : 0
}

locals {
  requester_vpc_id = !local.has_peering_id ? "" : data.aws_vpc_peering_connection.this[0].vpc_id
  accepter_vpc_id  = !local.has_peering_id ? "" : data.aws_vpc_peering_connection.this[0].peer_vpc_id
  is_acceptor      = local.accepter_vpc_id == local.vpc_id
  destination_cidr = !local.has_peering_id ? "" : (local.is_acceptor ? data.aws_vpc_peering_connection.this[0].peer_cidr_block : data.aws_vpc_peering_connection.this[0].cidr_block)
}

data "validation_error" "valid_vpc_id" {
  condition = local.has_peering_id && local.vpc_id != local.requester_vpc_id && local.vpc_id != local.accepter_vpc_id
  summary   = "The specified VPC peering connection does not connect the current network."
  details   = <<EOF
This block has a connection to a network to construct the peering routes.
The `peering_id` variable specifies a VPC peering connection that does not form a connection with the current network.
EOF
}
