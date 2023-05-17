# aws-vpc-peering-routes

This is a Nullstone modules to configure routes for a VPC to another VPC through a peering connection.

## How does this module work?

This module is connected to **only** one of the VPCs in Nullstone.
When configured and launched, this module adds routes to the connected VPC so that traffic originating from private subnets can reach the other VPC.

This module must be launched for both VPCs for the routing to work.
