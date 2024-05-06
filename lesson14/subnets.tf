data "yandex_vpc_network" "default" {
  network_id = "enp3bl2vdgupd8chb1m1"
}

resource "yandex_vpc_subnet" "public" {
  name           = "default-public"
  zone           = "ru-central1-d"
  network_id     = data.yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.150.0.0/28"]
}

resource "yandex_vpc_subnet" "private" {
  name           = "default-private"
  zone           = "ru-central1-d"
  network_id     = data.yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.0.0/28"]
}