terraform {
  required_version = ">= 0.12"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~>0.65.0"
    }
  }
}

provider "yandex" {
  token       = "<my-token-cloud>"
  cloud_id    = "<cloud-id>"
  folder_id   = "<folder-id-cloud>"
  zone        = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "swarm-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.28.10.0/24"]
}

module "swarm_cluster" {
  source        = "./modules/instance"
  vpc_subnet_id = yandex_vpc_subnet.subnet.id
  manager       = 1
  worker        = 2
}
