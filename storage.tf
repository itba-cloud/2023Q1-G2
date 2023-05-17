module "static-site" {
  source = "./modules/storage"

  resources   = var.static_resources
  name_prefix = var.name_prefix
}
