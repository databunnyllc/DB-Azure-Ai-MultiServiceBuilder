# Install Azure Modules
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser <= Uncomment this if Windows is blocking Powershell from running this line.
Install-Module -Name Az -Repository PSGallery -Force
Update-Module -Name Az -Force