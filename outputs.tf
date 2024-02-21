// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "id" {
  description = "The ID of the Firewall Policy."
  value       = azurerm_firewall_policy.firewall_policy.id
}

output "child_policies" {
  description = "The child policies of the Firewall Policy."
  value       = azurerm_firewall_policy.firewall_policy.child_policies
}

output "firewalls" {
  description = "A list of references to Azure Firewalls that this Firewall Policy is associated with."
  value       = azurerm_firewall_policy.firewall_policy.firewalls
}

output "rule_collection_groups" {
  description = "A list of references to Azure Firewall Rule Collection Groups that this Firewall Policy is associated with."
  value       = azurerm_firewall_policy.firewall_policy.rule_collection_groups
}

output "name" {
  description = "The name of the Firewall Policy."
  value       = var.name
}
