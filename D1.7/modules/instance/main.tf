data "yandex_compute_image" "my_image" {
  family = var.innstance_family_image
}

resource "yandex_compute_instance" "vm-manager" {
  count = var.manager
  name = "manager-${count.index}"
  hostname = "manager-${count.index}"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size = 15
      type = "network-ssd"
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-worker" {
  count = var.worker
  name = "worker-${count.index}"
  hostname = "worker-${count.index}"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size = 15
      type = "network-ssd"
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "local_file" "hosts-ansible" {
  content = templatefile("./hosts.tpl",
  {
    host_0    = yandex_compute_instance.vm-manager[0].hostname
    address_0 = yandex_compute_instance.vm-manager[0].network_interface.0.nat_ip_address

    host_1    = yandex_compute_instance.vm-worker[0].hostname
    address_1 = yandex_compute_instance.vm-worker[0].network_interface.0.nat_ip_address

    host_2    = yandex_compute_instance.vm-worker[1].hostname
    address_2 = yandex_compute_instance.vm-worker[1].network_interface.0.nat_ip_address

  }
  )
  filename = "./hosts"
}