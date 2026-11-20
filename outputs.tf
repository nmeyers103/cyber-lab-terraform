output "ubuntu_public_ip" {
  description = "Public IP of the Ubuntu VM"
  value       = module.ubuntu_vm.public_ip
}

output "windows_public_ip" {
  description = "Public IP of the Windows VM"
  value       = module.windows_vm.public_ip
}

output "kali_public_ip" {
  description = "Public IP of the Kali Linux VM"
  value       = module.kali_vm.public_ip
}
