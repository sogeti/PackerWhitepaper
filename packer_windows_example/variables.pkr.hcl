variable "tenant_id" {
  type      = string
  sensitive = true
}
variable "subscription_id" {
  type      = string
  sensitive = true
}
variable "client_id" {
  type      = string
  sensitive = true
}
variable "client_secret" {
  type      = string
  sensitive = true
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "image_name" {
  type = string
}
variable "image_version" {
  type = string
}
variable "shared_image_gallery_name" {
  type    = string
  default = ""
}
variable "shared_image_gallery_resource_group_name" {
  type    = string
  default = ""
}
variable "shared_image_gallery_locations" {
  type    = list(string)
  default = []
}