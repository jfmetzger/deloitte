output "instance_group" {
  value = [for group in google_compute_region_instance_group_manager.instance_group : group.instance_group]
}