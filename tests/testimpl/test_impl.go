package common

import (
	"context"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/nexient-llc/lcaf-component-terratest-common/lib/azure/configure"
	"github.com/nexient-llc/lcaf-component-terratest-common/lib/azure/login"
	"github.com/nexient-llc/lcaf-component-terratest-common/lib/azure/network"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	"github.com/stretchr/testify/assert"
)

const terraformDir string = "../../examples/firewall_policy"
const varFile string = "test.tfvars"

func TestFirewall(t *testing.T, ctx types.TestContext) {

	envVarMap := login.GetEnvironmentVariables()
	clientID := envVarMap["clientID"]
	clientSecret := envVarMap["clientSecret"]
	tenantID := envVarMap["tenantID"]
	subscriptionID := envVarMap["subscriptionID"]

	spt, err := login.GetServicePrincipalToken(clientID, clientSecret, tenantID)
	if err != nil {
		t.Fatalf("Error getting Service Principal Token: %v", err)
	}

	firewallsClient := network.GetFirewallsClient(spt, subscriptionID)
	terraformOptions := configure.ConfigureTerraform(terraformDir, []string{terraformDir + "/" + varFile})

	firewallIds := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "firewall_ids")
	for range firewallIds {
		t.Run("doesfirewallExist", func(t *testing.T) {
			resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
			firewallNames := terraform.OutputMap(t, terraformOptions, "firewall_names")

			for _, firewallName := range firewallNames {
				inputFirewallName := strings.Trim(firewallName, "\"[]")
				firewallInstance, err := firewallsClient.Get(context.Background(), resourceGroupName, inputFirewallName)
				if err != nil {
					t.Fatalf("Error getting firewall: %v", err)
				}
				if firewallInstance.Name == nil {
					t.Fatalf("Firewall does not exist")
				}
				assert.Equal(t, strings.ToLower(inputFirewallName), getFirewallName(strings.ToLower(*firewallInstance.Name)))
				assert.NotEmpty(t, (*firewallInstance.IPConfigurations))
				assert.NotEmpty(t, (*firewallInstance.FirewallPolicy.ID))
			}
		})
	}
}

func getFirewallName(input string) string {
	parts := strings.Split(input, "/")
	return parts[len(parts)-1]
}
