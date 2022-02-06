

module "acd-onix-gce-001" {
  source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.14"
  compute_name    = "acd-onix-gce-${var.env_alias}-001"
  compute_seq     = ""
  vm_tags         = ["acd-onix-gce"]
  vm_service_account = ""
  
  # For some reason the Ubuntu image will not allow terraform to connect to VM - "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20210927"
  boot_disk_image  = "projects/centos-cloud/global/images/centos-7-v20220118" 
  boot_disk_size   = 100
  public_key_file  = "id_rsa.pub"
  private_key_file = "id_rsa"
  vm_machine_type  = "e2-small"
  vm_machine_zone  = "asia-southeast1-b"
  vm_deletion_protection = false
  ssh_user         = "devops"
  provisioner_local_path  = "setup.bash"
  provisioner_remote_path = "/home/devops"
  external_disks   = []
  network_configs  = [{index = 1, network = "default", nat_ip = ""}]
  create_nat_ip = true
  remote_exec_by_nat_ip = true
  startup_script_local_path = "startup.bash"
}


# Added auto snapshot here

resource "google_compute_disk_resource_policy_attachment" "attachment-001" {
  name = google_compute_resource_policy.snapshot-policy-001.name
  disk = "acd-onix-gce-${var.env_alias}-001"
  zone = "asia-southeast1-b"
}

resource "google_compute_resource_policy" "snapshot-policy-001" {
  name = "acd-onix-gce-${var.env_alias}-001"
  region = "asia-southeast1"
  snapshot_schedule_policy {
    schedule {
      hourly_schedule {
        hours_in_cycle = 6
        start_time = "00:00"
      }
    }

    retention_policy {
      max_retention_days    = 7
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }    
  }
}