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

variable "name" {
  description = "(Required) The name which should be used for this Firewall Policy. Changing this forces a new Firewall Policy to be created."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created."
  type        = string
}

variable "base_policy_id" {
  description = "(Optional) The ID of the base Firewall Policy."
  type        = string
  default     = null
}

variable "dns" {
  description = "(Optional) Dns block"
  type = object({
    proxy_enabled = bool
    servers       = list(string)
  })
  default = null
}

variable "identity" {
  description = "(Optional) A identity block"
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = null
}

variable "insights" {
  description = "(Optional) A insights block"
  type = object({
    enabled                            = bool
    default_log_analytics_workspace_id = string
    retention_in_days                  = number
    log_analytics_workspace = list(object({
      id                = string
      firewall_location = string
    }))
  })
  default = null
}

variable "intrusion_detection" {
  description = "(Optional) Intrusion detection is feature provided by Azure Firewall Premium tier for network intrusion detection and prevention. To configure intrusion detection, aintrusion_detection block with below arguments is required. More information for each of these attributes can found at https://learn.microsoft.com/en-us/azure/firewall/premium-features#idps and https://techcommunity.microsoft.com/t5/azure-network-security-blog/intrusion-detection-and-prevention-system-idps-based-on/ba-p/3921330"
  type = object({
    mode = string
    signature_overrides = list(object({
      id    = number
      state = string
    }))
    traffic_bypass = object({
      name                  = string
      protocol              = string
      description           = optional(string)
      destination_addresses = optional(list(string))
      destination_ip_groups = optional(list(string))
      destination_ports     = optional(list(string))
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
    })
    private_ranges = list(string)
  })
  default = null
}

variable "private_ip_ranges" {
  description = "(Optional) A list of private IP ranges to which traffic will not be SNAT."
  type        = list(string)
  default     = null
}

variable "auto_learn_private_ranges_enabled" {
  description = "(Optional) Enable or disable auto learning of private IP ranges."
  type        = bool
  default     = null
}

variable "sku" {
  description = "(Optional) The SKU Tier of the Firewall Policy. Possible values are Standard, Premium and Basic. Changing this forces a new Firewall Policy to be created."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to the Firewall Policy."
  type        = map(string)
  default     = {}
}
