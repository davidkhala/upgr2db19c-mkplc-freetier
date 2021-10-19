/*
********************
# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# by - Rene Fontcha - Oracle LiveLabs Platform Lead
# Last Updated - 08/23/2021
********************
*/

/*
********************
Marketplace UI Parameters
********************
*/

variable use_marketplace_image {
  default = true
}

variable mp_listing_id {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaa35wgnzdxzt7eplb22gp4bxbnukw5kamucvwrqy3cngggujck452q"
}

variable mp_listing_resource_version {
  default = "2.1"
}

variable instance_image_id {
  default = "ocid1.image.oc1..aaaaaaaaiije4tai42tl34f4h4p44eh3zhcl6rtugfjjugy4fqlmtczyy4tq"
}

/*
******************************
Desktop URLs Injection
******************************
*/
variable "novnc_delay_sec" {
  default = "420s"
}

variable "desktop_guide_url" {
  default = "https://oracle.github.io/learning-library/data-management-library/database/upgrade/19c/workshops/desktop"
}

variable "desktop_app1_url" {
  default = ""
}

variable "desktop_app2_url" {
  default = ""
}

/*
******************************
Basic Configuration Details
******************************
*/

variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "region" {}
variable "availability_domain_name" {}
# variable "ssh_public_key" {}

variable "shape_use_flex" {
  default = true
}

variable "flex_instance_shape" {
  default = "VM.Standard.E4.Flex"
}

variable "fixed_instance_shape" {
  default = "VM.Standard.E2.2"
}

variable "instance_count" {
  default = 1
}

variable "instance_shape_config_ocpus" {
  default = 2
}

variable "vcn_use_existing" {
  default = false
}
variable "vcn_existing" {
  default = ""
}
variable "subnet_public_existing" {
  default = ""
}

#*************************************
#        Local Variables
#*************************************
locals {
  public_subnet_id = var.vcn_use_existing ? var.subnet_public_existing : oci_core_subnet.public-subnet-up2db19c[0].id
  timestamp        = formatdate("YYYY-MM-DD-hhmmss", timestamp())
  instance_shape   = var.shape_use_flex ? var.flex_instance_shape : var.fixed_instance_shape
  is_flex_shape    = var.shape_use_flex ? [var.instance_shape_config_ocpus] : []
}
