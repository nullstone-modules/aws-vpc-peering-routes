data "aws_route_tables" "private" {
  vpc_id = local.vpc_id

  filter {
    name   = "association.subnet-id"
    values = local.private_subnet_ids
  }
}

resource "aws_route" "this" {
  for_each = local.has_peering_id ? toset(data.aws_route_tables.private.ids) : toset([])

  route_table_id            = each.value
  destination_cidr_block    = local.destination_cidr
  vpc_peering_connection_id = var.peering_id
}
