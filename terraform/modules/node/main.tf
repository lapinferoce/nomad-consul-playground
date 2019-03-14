
# We fetch the latest ubuntu release image from their mirrors
resource "libvirt_volume"  "nomad-node1-qcow2" {
  name = "nomad-node1-qcow2-${count.index}" 

  pool = "default"
  source = "file:///home/eric/Perso/nomad/terraform/Fedora-Cloud-Base-29-1.2.x86_64.qcow2"
  format = "qcow2"
  count= "${var.number}"
}

variable "commonid" {}
variable "number" {}

resource "ansible_host" "node"{
  inventory_hostname = "nomad-node${count.index}"
  groups = ["nomad-node","consul-agent"]
  count= "${var.number}"
  vars{
    ansible_host="${element(flatten(libvirt_domain.nomad-node1.*.network_interface.0.addresses),count.index)}"
    ansible_user="fedora"
    ansible_port=22
    ansible_python_interpreter="/usr/bin/python3"
  }

}


# Create the machine
resource "libvirt_domain" "nomad-node1" {
  count= "${var.number}"
  name = "nomad-node${count.index}"
  memory = "2048"
  vcpu = 2

#  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"
  cloudinit = "${var.commonid}"

  network_interface {
    network_name = "nomad_net"
    wait_for_lease = "true"
  }

  # IMPORTANT
  # Ubuntu can hang if an isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = "${element(libvirt_volume.nomad-node1-qcow2.*.id, count.index)}"
#"${libvirt_volume.nomad-node1-qcow2.id}"
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

output "ip"{
 value = "${libvirt_domain.nomad-node1.*.network_interface.0.addresses}"
}
