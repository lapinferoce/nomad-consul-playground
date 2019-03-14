
# Print the Boxes IP
# Note: you can use `virsh domifaddr <vm_name> <interface>` to get the ip later
output "ip-master" {
  value = "${module.nomad_master.ip }" #"libvirt_domain.nomad-master.network_interface.0.addresses.0}"

}
output "ip-node1" {
  value = "${module.nomad_node.ip}" #"libvirt_domain.nomad-node1.network_interface.0.addresses.0}"

}
