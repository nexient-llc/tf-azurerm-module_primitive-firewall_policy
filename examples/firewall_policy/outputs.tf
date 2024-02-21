# // Licensed under the Apache License, Version 2.0 (the "License");
# // you may not use this file except in compliance with the License.
# // You may obtain a copy of the License at
# //
# //     http://www.apache.org/licenses/LICENSE-2.0
# //
# // Unless required by applicable law or agreed to in writing, software
# // distributed under the License is distributed on an "AS IS" BASIS,
# // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# // See the License for the specific language governing permissions and
# // limitations under the License.

# //outputs by firewall module
output "firewall_ids" {
  value       = module.firewall.firewall_ids
  description = "Firewall generated ids"
}

output "firewall_names" {
  value       = module.firewall.firewall_names
  description = "Firewall names"
}

output "private_ip_addresses" {
  value       = module.firewall.private_ip_addresses
  description = "Firewall private IP"
}

output "public_ip_addresses" {
  value       = module.firewall.public_ip_addresses
  description = "Firewall public IP"
}

output "subnet_ids" {
  value       = module.firewall.subnet_ids
  description = "ID of the subnet attached to the firewall"
}

output "resource_group_name" {
  value       = module.resource_group.name
  description = "Resource group name"
}
