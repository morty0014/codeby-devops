data "yandex_compute_image" "hdd_vm_1" {
  family = "debian-12"
}

data "yandex_compute_image" "hdd_vm_2" {
  family = "debian-12"
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
}

resource "yandex_compute_instance" "vm_public" {
  name                      = "vm-public-1"
  platform_id               = "standard-v2"
  allow_stopping_for_update = true
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.hdd_vm_1.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.public_security_group.id}"]
  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
    ssh-keys  = "kali:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "vm_private" {
  name                      = "vm-private-1"
  platform_id               = "standard-v2"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.hdd_vm_2.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
    security_group_ids = ["${yandex_vpc_security_group.public_security_group.id}"]
  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
    ssh-keys  = "kali:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_vpc_security_group" "public_security_group" {
  name        = "Public security group"
  description = "My security group for public network"
  network_id  = data.yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTPs"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "rule2 description"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "private_security_group" {
  name        = "Private security group"
  description = "My security group for private network"
  network_id  = data.yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    description    = "Allow 8080 port"
    v4_cidr_blocks = yandex_vpc_subnet.private.v4_cidr_blocks
    port           = 8080
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH"
    v4_cidr_blocks = yandex_vpc_subnet.private.v4_cidr_blocks
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "rule2 description"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "fv4tmv4c5254okqvtgsb"
resource "yandex_compute_instance" "importtf" {
  allow_recreate            = null
  allow_stopping_for_update = null
  description               = "vm for tf import"
  folder_id                 = "b1gig1tjmkisb5vnasno"
  gpu_cluster_id            = null
  hostname                  = "importtf"
  labels                    = {}
  maintenance_grace_period  = null
  maintenance_policy        = null
  metadata = {
    install-unified-agent = "0"
    serial-port-enable    = "0"
    ssh-keys              = "debian:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIxMpxqhcgcK7oSY+KJNRVwWlqpE8JHvmLqTvnZvimR5ftkeC3jP5+IaIVAIT10p6S0gFGI0NXfRh5bBxb2wlZta8eECP0asHK7V0/Ie1/gq6gbRZ1enJCPnZxiht5LJQwlsGMUGmEn5K1339tWReHcbNPoCI/y9fAKFog+spxAC/ObtSFfM/kfZUoD10IBLQt7tZf3pw8+be04/VJ6yxATAoVkAVAez6Nv+8EqkiX+uQTFeWMgZWkDdjkYfGmPtEMy1HGkR1Ab2Qo4L7iuBZDbt7Qd65h/TQw6Uz5xQPtarTSp2jlZHA+ALWaSVveQozA/gWncMalRm6hn+It+4oUtYgpel0Wp+PABkAuK8MclIzAGqilB3UsYjufhsC8LhYiS4KWEWwHuSNVQhkqdd5/By4bU/5zhE+z7MpN3eBxgl1+aRknLYzZVl+HoRvybFINExRRBzusUljBu/xzbSLU1B9l13XaP2vXM9P9QXMZdlu3VQhbtkuLtI2idEf2Ietq+eLnWKTN6npxLoqo1N3wU+SeoyscBW0jurFZFqZPtPljjbKupXmwsJ4V4Kv9Rofa2xDwkBKfZNAddyY5OwP4lSG0aRTLNbWPEUh0Uy12ZyfzRILKmcu+gOhiAYqIk6ZMa5aPlCGNxy+D/ilR+dcfp4fJbIfl8o7FOQZY75aSqw== kali@kali"
    user-data             = "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: debian\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIxMpxqhcgcK7oSY+KJNRVwWlqpE8JHvmLqTvnZvimR5ftkeC3jP5+IaIVAIT10p6S0gFGI0NXfRh5bBxb2wlZta8eECP0asHK7V0/Ie1/gq6gbRZ1enJCPnZxiht5LJQwlsGMUGmEn5K1339tWReHcbNPoCI/y9fAKFog+spxAC/ObtSFfM/kfZUoD10IBLQt7tZf3pw8+be04/VJ6yxATAoVkAVAez6Nv+8EqkiX+uQTFeWMgZWkDdjkYfGmPtEMy1HGkR1Ab2Qo4L7iuBZDbt7Qd65h/TQw6Uz5xQPtarTSp2jlZHA+ALWaSVveQozA/gWncMalRm6hn+It+4oUtYgpel0Wp+PABkAuK8MclIzAGqilB3UsYjufhsC8LhYiS4KWEWwHuSNVQhkqdd5/By4bU/5zhE+z7MpN3eBxgl1+aRknLYzZVl+HoRvybFINExRRBzusUljBu/xzbSLU1B9l13XaP2vXM9P9QXMZdlu3VQhbtkuLtI2idEf2Ietq+eLnWKTN6npxLoqo1N3wU+SeoyscBW0jurFZFqZPtPljjbKupXmwsJ4V4Kv9Rofa2xDwkBKfZNAddyY5OwP4lSG0aRTLNbWPEUh0Uy12ZyfzRILKmcu+gOhiAYqIk6ZMa5aPlCGNxy+D/ilR+dcfp4fJbIfl8o7FOQZY75aSqw== kali@kali\n#cloud-config\nruncmd: []\n"
  }
  name                      = "importtf"
  network_acceleration_type = "standard"
  platform_id               = "standard-v2"
  service_account_id        = "aje7a20sja747img5s5f"
  zone                      = "ru-central1-d"
  boot_disk {
    auto_delete = true
    device_name = "fv4dmrn9kflhdcfp28e7"
    disk_id     = "fv4dmrn9kflhdcfp28e7"
    mode        = "READ_WRITE"
    initialize_params {
      block_size  = 4096
      description = null
      image_id    = "fd8kenjocebpg0kqenpp"
      name        = null
      size        = 5
      snapshot_id = null
      type        = "network-hdd"
    }
  }
  metadata_options {
    aws_v1_http_endpoint = 1
    aws_v1_http_token    = 2
    gce_http_endpoint    = 1
    gce_http_token       = 1
  }
  network_interface {
    ip_address         = "10.131.0.25"
    ipv4               = true
    ipv6               = false
    ipv6_address       = null
    nat                = true
    nat_ip_address     = "158.160.150.250"
    security_group_ids = []
    subnet_id          = "fl82mbg6lqu6i5kbdnke"
  }
  placement_policy {
    host_affinity_rules       = []
    placement_group_id        = null
    placement_group_partition = 0
  }
  resources {
    core_fraction = 5
    cores         = 2
    gpus          = 0
    memory        = 1
  }
  scheduling_policy {
    preemptible = true
  }
}