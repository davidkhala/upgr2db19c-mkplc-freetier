/*
********************
# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# by - Rene Fontcha - Oracle LiveLabs Platform Lead
# Last Updated - 04/01/2021
********************
*/

terraform {
  required_version = "~> 0.13.0"
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  region       = var.region
}
