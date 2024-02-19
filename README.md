# tf-azurerm-module_primitive-firewall_policy

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module creates a firewall policy.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name                                                                      | Version   |
| ------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | ~> 3.77.0 |

## Providers

| Name                                                          | Version |
| ------------------------------------------------------------- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.77.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                       | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [azurerm_firewall_policy.firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |

## Inputs

| Name                                                                                                                                          | Description                                                                                                                                                | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Default | Required |
| --------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name)                                                                                                | (Required) The name which should be used for this Firewall Policy. Changing this forces a new Firewall Policy to be created.                               | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | n/a     |   yes    |
| <a name="input_location"></a> [location](#input\_location)                                                                                    | (Required) The Azure Region where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created.                              | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                               | (Required) The name of the Resource Group where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created.                | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | n/a     |   yes    |
| <a name="input_base_policy_id"></a> [base\_policy\_id](#input\_base\_policy\_id)                                                              | (Optional) The ID of the base Firewall Policy.                                                                                                             | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `null`  |    no    |
| <a name="input_dns"></a> [dns](#input\_dns)                                                                                                   | (Optional) Dns block                                                                                                                                       | <pre>object({<br>    proxy_enabled = bool<br>    servers       = list(string)<br>  })</pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `null`  |    no    |
| <a name="input_identity"></a> [identity](#input\_identity)                                                                                    | (Optional) A identity block                                                                                                                                | <pre>object({<br>    type         = string<br>    identity_ids = list(string)<br>  })</pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `null`  |    no    |
| <a name="input_insights"></a> [insights](#input\_insights)                                                                                    | (Optional) A insights block                                                                                                                                | <pre>object({<br>    enabled                            = bool<br>    default_log_analytics_workspace_id = string<br>    retention_in_days                  = number<br>    log_analytics_workspace = list(object({<br>      id                = string<br>      firewall_location = string<br>    }))<br>  })</pre>                                                                                                                                                                                                                                                                                                                                             | `null`  |    no    |
| <a name="input_intrusion_detection"></a> [intrusion\_detection](#input\_intrusion\_detection)                                                 | (Optional) A intrusion\_detection block                                                                                                                    | <pre>object({<br>    mode = string<br>    signature_overrides = list(object({<br>      id    = number<br>      state = string<br>    }))<br>    traffic_bypass = object({<br>      name                  = string<br>      protocol              = string<br>      description           = optional(string)<br>      destination_addresses = optional(list(string))<br>      destination_ip_groups = optional(list(string))<br>      destination_ports     = optional(list(string))<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>    })<br>    private_ranges = list(string)<br>  })</pre> | `null`  |    no    |
| <a name="input_private_ip_ranges"></a> [private\_ip\_ranges](#input\_private\_ip\_ranges)                                                     | (Optional) A list of private IP ranges to which traffic will not be SNAT.                                                                                  | `list(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `null`  |    no    |
| <a name="input_auto_learn_private_ranges_enabled"></a> [auto\_learn\_private\_ranges\_enabled](#input\_auto\_learn\_private\_ranges\_enabled) | (Optional) Enable or disable auto learning of private IP ranges.                                                                                           | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `null`  |    no    |
| <a name="input_sku"></a> [sku](#input\_sku)                                                                                                   | (Optional) The SKU Tier of the Firewall Policy. Possible values are Standard, Premium and Basic. Changing this forces a new Firewall Policy to be created. | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `null`  |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                | (Optional) A mapping of tags which should be assigned to the Firewall Policy.                                                                              | `map(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `{}`    |    no    |

## Outputs

| Name                                                                                                       | Description                                                                                                 |
| ---------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| <a name="output_id"></a> [id](#output\_id)                                                                 | The ID of the Firewall Policy.                                                                              |
| <a name="output_child_policies"></a> [child\_policies](#output\_child\_policies)                           | The child policies of the Firewall Policy.                                                                  |
| <a name="output_firewalls"></a> [firewalls](#output\_firewalls)                                            | A list of references to Azure Firewalls that this Firewall Policy is associated with.                       |
| <a name="output_rule_collection_groups"></a> [rule\_collection\_groups](#output\_rule\_collection\_groups) | A list of references to Azure Firewall Rule Collection Groups that this Firewall Policy is associated with. |
| <a name="output_name"></a> [name](#output\_name)                                                           | The name of the Firewall Policy.                                                                            |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
