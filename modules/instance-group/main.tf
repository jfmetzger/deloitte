data "google_compute_image" "debian_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_instance_template" "instance_template" {
  for_each     = var.regions
  name         = "${var.project}-${terraform.workspace}-instance-template-${each.value}"
  machine_type = var.machine_type
  network_interface {
    network    = var.vpc_id
    subnetwork = var.subnets[each.value].id
    access_config {
    }
  }

  disk {
    source_image = data.google_compute_image.debian_image.self_link
    auto_delete  = true
    boot         = true
  }

  metadata_startup_script = file(var.startup_script)

  tags = ["webserver", "lb-health-check", "allow-ssh"]

  scheduling {
    automatic_restart = !var.preemptible
    preemptible       = var.preemptible
  }
}


resource "google_compute_region_instance_group_manager" "instance_group" {
  for_each = var.regions
  name     = "${var.project}-${terraform.workspace}-instance-group-${each.value}"
  region   = each.value
  version {
    instance_template = google_compute_instance_template.instance_template[each.value].id
    name              = "primary"
  }

  base_instance_name = "${var.project}-webserver-${terraform.workspace}"
  target_size        = var.instance_count
  
  named_port {
    name = "http"
    port = 80
  }   
}