# Variables for common values
$subscription= "exemplo"
$resourceGroup = "myResourceGroup"
$location = "westeurope"
$vmName = "myVM"
$AdminUserName = "login"
$AdminPassword = ConvertTo-SecureString 'senha' -AsPlainText -Force

Set-AzContext -Subscription $subscription

# Create user object
$Cred = New-Object System.Management.Automation.PSCredential ($AdminUserName, $AdminPassword)

# Create a virtual machine
New-AzVM `
  -ResourceGroupName $resourceGroup `
  -Name $vmName `
  -Location $location `
  -ImageName "Win2016Datacenter" `
  -VirtualNetworkName "myVnet" `
  -SubnetName "mySubnet" `
  -SecurityGroupName "myNetworkSecurityGroup" `
  -PublicIpAddressName "myPublicIp" `
  -Credential $Cred 