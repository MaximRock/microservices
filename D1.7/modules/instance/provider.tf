terraform {
  required_version = ">= 0.12"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~>0.65.0"
    }
  }
}