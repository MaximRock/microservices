output "internal_ip_address_manager" {
  #value = [for vm in yandex_compute_instance.vm : vm.network_interface.0.ip_address]
  value = yandex_compute_instance.vm-manager[*].network_interface.0.nat_ip_address
}

output "external_ip_address_worker" {
  #value = [for vm in yandex_compute_instance.vm : vm.network_interface.0.nat_ip_address]
  value = yandex_compute_instance.vm-worker[*].network_interface.0.nat_ip_address
}
