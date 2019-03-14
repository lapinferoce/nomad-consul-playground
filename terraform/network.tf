# Create a network for our VMs
resource "libvirt_network" "nomad_net" {
  name = "nomad_net"
  mode = "nat"
  domain="nomad.net"
  addresses = ["192.168.125.0/24"]
  dhcp {
    enabled = true
  }

 dns {
  local_only=true
 }
}
