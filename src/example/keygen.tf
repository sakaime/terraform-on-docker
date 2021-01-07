variable "key_name" {
  type        = string
  description = "keypair name"
  default     = "example"
}

locals {
  public_key_file  = "./${var.key_name}.id_rsa.pub"
  private_key_file = "./${var.key_name}.id_rsa"
}

resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  filename = local.private_key_file
  content  = tls_private_key.keygen.private_key_pem

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_file}"
  }
}

resource "local_file" "public_key_openssh" {
  filename = local.public_key_file
  content  = tls_private_key.keygen.public_key_openssh

  provisioner "local-exec" {
    command = "chmod 600 ${local.public_key_file}"
  }
}