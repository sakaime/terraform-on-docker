output "public_ip" {
  value = aws_eip.example.public_ip
}

output "key_name" {
  value = var.key_name
}

output "private_key_file" {
  value = local.private_key_file
}

output "private_key_pem" {
  value = tls_private_key.keygen.private_key_pem
}

output "public_key_file" {
  value = local.public_key_file
}

output "public_key_openssh" {
  value = tls_private_key.keygen.public_key_openssh
}