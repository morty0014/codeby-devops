terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = file("~/terraform/key.json")
  cloud_id                 = var.YC_CLOUD_ID
  folder_id                = var.YC_FOLDER_ID
  zone                     = "ru-central1-d"
}