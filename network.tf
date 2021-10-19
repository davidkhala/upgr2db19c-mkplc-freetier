/*
********************
# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# by - Rene Fontcha - Oracle LiveLabs Platform Lead
# Last Updated - 08/23/2021
********************
*/

resource "oci_core_vcn" "up2db19c" {
  count          = var.vcn_use_existing ? 0 : 1
  cidr_block     = "10.0.0.0/16"
  dns_label      = "up2db19c"
  compartment_id = var.compartment_ocid
  display_name   = "up2db19c-net-${local.timestamp}"
  lifecycle {
    ignore_changes = [
      display_name,
    ]
  }
}

resource "oci_core_internet_gateway" "up2db19c-internet-gateway" {
  count          = var.vcn_use_existing ? 0 : 1
  compartment_id = var.compartment_ocid
  display_name   = "up2db19c Internet Gateway"
  enabled        = true
  vcn_id         = oci_core_vcn.up2db19c[0].id
}

resource "oci_core_route_table" "up2db19c-public-rt" {
  count          = var.vcn_use_existing ? 0 : 1
  display_name   = "up2db19c Route Table"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.up2db19c[0].id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.up2db19c-internet-gateway[0].id
  }
}

resource "oci_core_security_list" "up2db19c-security-list" {
  count          = var.vcn_use_existing ? 0 : 1
  display_name   = "up2db19c Security List"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.up2db19c[0].id

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  // allow inbound tpc traffic
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 6080
      max = 6080
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol = 1
    source   = "0.0.0.0/0"

    icmp_options {
      type = 3
      code = 4
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol = "all"
    source   = "10.0.0.0/16"
  }
}

resource "oci_core_subnet" "public-subnet-up2db19c" {
  count             = var.vcn_use_existing ? 0 : 1
  cidr_block        = "10.0.0.0/24"
  display_name      = "up2db19c Public Subnet"
  dns_label         = "pub"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.up2db19c[0].id
  route_table_id    = oci_core_route_table.up2db19c-public-rt[0].id
  security_list_ids = [oci_core_security_list.up2db19c-security-list[0].id]
}
