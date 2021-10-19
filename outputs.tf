/*
********************
# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# by - Rene Fontcha - Oracle LiveLabs Platform Lead
# Last Updated - 08/23/2021
********************
*/
output "workshop_desc" {
  value = format("Multi Labs Workshops Setup for Upgrade to Oracle Dabatase 19c on LiveLabs. Count of total instances provisioned: %s virtual machines of shape %s ",
    var.instance_count,
    local.instance_shape
  )
}

output "instances" {
  value = formatlist("%s - %s",
    oci_core_instance.up2db19c-hol.*.display_name,
    oci_core_instance.up2db19c-hol.*.public_ip
  )
}
output "remote_desktop" {
  value = formatlist("http://%s%s%s%s",
    oci_core_instance.up2db19c-hol.*.public_ip,
    ":6080/vnc.html?password=",
    random_string.vncpwd.*.result,
    "&resize=scale&quality=9&autoconnect=true"
  )
}
