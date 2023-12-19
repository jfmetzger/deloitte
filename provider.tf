terraform {

  backend "gcs" {
    bucket = "my-bucket-my-capstone-project-407419"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
  }
}

provider "google" {
  #  credentials = file("../my-capstone-project-407419-a5e6ffb97061.json")
  project = var.project_id
}