# instance the provider
provider "libvirt" {
  uri = "qemu+tcp://127.0.0.1/system"
}


module "nomad_master" {
  source = "modules/master"
  commonid = "${libvirt_cloudinit_disk.commoninit.id}"
  number="3"
}

# name should be a list and we should iterate over it in the module
module "nomad_node" {
  source = "modules/node"
  commonid = "${libvirt_cloudinit_disk.commoninit.id}"

  number="4"
}

