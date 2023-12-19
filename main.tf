# Create the Network
module "vpc" {
  source       = "./modules/vpc"
  project      = var.project
  regions      = var.regions
  subnet_cidrs = var.subnet_cidrs
}

#module "instance-group" {
#  source = "./modules/instance-group"
#  project = var.project
#  regions = var.regions
#  machine_type = var.machine_type
#  preemptible = var.preemptible
#  instance_count = var.instance_count
#  startup_script = var.startup_script
#  vpc_id = module.vpc.vpc_id
#  subnets = module.vpc.subnets
#}

#module "load-balancer" {
#  source = "./modules/load-balancer"
#  project = var.project
#  regions = var.regions
#  instance_group = module.instance-group.instance_group
#}