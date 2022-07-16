build {
  sources = ["source.azure-arm.windows2022"]

  provisioner "powershell" {
    script = "scripts/main.ps1"
  }
}