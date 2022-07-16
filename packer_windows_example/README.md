# Project: Packer Azure Windows 2022 Datacenter Azure Edition Image

This example project can be used to build a Windows Server 2022 Datacenter Azure Edition image using packer.
We also install for demo purposes IIS and create a single HTML page with a message.

## Shared Image Gallery

As an optional functionality, we opt to publish the image to a shared image gallery by configuring the following packer variables:

- shared_image_gallery_name
- shared_image_gallery_resource_group_name
- shared_image_gallery_locations

In order to create the image gallery, you can run the following commands:

```bash
az sig create --resource-group $RG_NAME --gallery-name $SIG_NAME

az sig image-definition create -g $RG_NAME --gallery-name $SIG_NAME --gallery-image-
        definition $IMAGE_NAME --publisher $PUBLISHER --offer $OFFER --sku $SKU --os-type "windows"
```

Terraform can also create your SIG, like below:
```terraform
resource "azurerm_shared_image" "vm" {
  name                = "vmname"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.sig.name
  location            = azurerm_resource_group.sig.location
  os_type             = "Windows"
  hyper_v_generation  = "V2"

  identifier {
    publisher = "YourCompany"
    offer     = "WindowsServer"
    sku       = "YourApp"
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags,
    ]
  }
}
```

**NOTE**: The name and the values of the image definition in the shared image gallery, must match the managed image created by packer.

## Packer

The example pipeline 'packer-pipeline.yml' is setup to use Azure DevOps and use the service principal associated with the variable named arm_connection.

To run the this code on your machine you need to provide the following packer variables in order to authenticate using your service principal:

```bash

# Set service principal envionrment variables
export PKR_VAR_client_id="..."
export PKR_VAR_client_secret="..."
export PKR_VAR_subscription_id="..."
export PKR_VAR_tenant_id="..."

# Run packer
packer build -var-file="example.pkrvars.hcl" .
```
