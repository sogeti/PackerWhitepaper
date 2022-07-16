
local "shared_image_gallery" {
  expression = var.shared_image_gallery_name != "" ? true : false
}

source "azure-arm" "windows2022" {
  location = var.location

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret

  managed_image_resource_group_name = var.resource_group_name
  managed_image_name                = "${var.image_name}-${var.image_version}"

  image_offer     = "WindowsServer"
  image_publisher = "MicrosoftWindowsServer"
  image_sku       = "2022-datacenter-azure-edition" # Be sure to check if this is a V1 or V2 VM!
  os_type         = "Windows"
  vm_size         = "Standard_D2s_v4"

  communicator   = "winrm"
  winrm_use_ssl  = true
  winrm_insecure = true
  winrm_timeout  = "10m"
  winrm_username = "packer"

  dynamic "shared_image_gallery_destination" {
    for_each = local.shared_image_gallery ? [1] : []

    content {
      subscription        = var.subscription_id
      resource_group      = var.shared_image_gallery_resource_group_name
      gallery_name        = var.shared_image_gallery_name
      image_name          = var.image_name
      image_version       = var.image_version
      replication_regions = var.shared_image_gallery_locations
    }
  }

  azure_tags = {
    image_version = var.image_version
  }
}