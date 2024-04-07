
# This powershell script builds a base Ai multi-service lab

#Have user connect to Azure.
echo "SIGNING YOU INTO AZURE..."
Connect-AzAccount
# Generates a random number
$randomize = Get-Random -Minimum 100 -Maximum 200
# Ask user for the name of their resource group.
$ResourceGroupName = Read-Host -Prompt "`nPLEASE ENTER A RESOURCE GROUP NAME"
# Ask user for the location of the resource group.
$chosenLocation = Read-Host -Prompt "`nENTER NUMBER OF THE RESOURCE GROUP LOCATION:`n 
                                        1) East US | 2) East US 2 | 3) Central US`n
                                        4) West US | 5) West US 2 | 6) Canada Central`n
                                        7) Japan West | 8) South Africa North`n"
$rgLocation = Switch ($chosenLocation) {
    1 {"eastus"; Break}
    2 {"eastus2"; Break}
    3 {"centralus"; Break}
    4 {"westus"; Break}
    5 {"westus2"; Break}
    6 {"canadacentral"; Break}
    7 {"japanwest"; Break}
    8 {"southafricanorth"; Break}
}
echo "`nRESOURCE GROUP LOCATION: $rgLocation!"

# Create storage account in resource group.
echo "`nNO SPACES!"
$storageAccountName = Read-Host -Prompt "`nWHAT IS THE NAME OF YOUR STORAGE ACCOUNT? "

# append the name of storage account and add random number to the end.
$uniqueStorageAccountName = "$storageAccountName$randomize"

# Enter name of congnitive service.
echo "NO SPACES!"
$cognitiveServicesName = Read-Host -Prompt "`nTYPE THE NAME OF YOUR COGNITIVE SERVICE"


# Build the Ai Lab
# Build the resource group.
echo "`nBUILDING YOUR RESOURCE GROUP..."
New-AzResourceGroup -Name $ResourceGroupName -Location $rgLocation
echo "`nCREATING A STORAGE ACCOUNT IN RESOURCE GROUP $ResourceGroupName...".ToUpper()
New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $uniqueStorageAccountName -Location $rgLocation -SkuName Standard_GRS -Kind BlobStorage -AccessTier Hot
echo "`nCREATING A AZURE COGNITIVE MULTI-SERVICE..."
New-AzCognitiveServicesAccount -ResourceGroupName $ResourceGroupName -Name $cognitiveServicesName -Location $rgLocation -Type CognitiveServices -SkuName S0 -PublicNetworkAccess Enabled

echo "`nALL DONE! I HOPE YOU ENJOY YOUR LAB!"