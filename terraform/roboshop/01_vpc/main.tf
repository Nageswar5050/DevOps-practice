module "roboshop_vpc" {
  source               = "../../modules/vpc"
  common_tags          = var.common_tags
  project_name         = var.project_name
  environment          = var.environment
  frontend_subnet_cidr = var.frontend_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr
  backend_subnet_cidr  = var.backend_subnet_cidr
}