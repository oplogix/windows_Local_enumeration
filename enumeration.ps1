# Check for administrator privileges
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  # If user is not an administrator, display an error message and exit the script
  Write-Output "Error: You must run this script with administrator privileges."
  exit
}
echo "^
  /$$$$$$            /$$                           /$$          ^
 /$$__  $$          | $$                          |__/          ^
| $$  \ $$  /$$$$$$ | $$        /$$$$$$   /$$$$$$  /$$ /$$   /$$^
| $$  | $$ /$$__  $$| $$       /$$__  $$ /$$__  $$| $$|  $$ /$$/^
| $$  | $$| $$  \ $$| $$      | $$  \ $$| $$  \ $$| $$ \  $$$$/ ^
| $$  | $$| $$  | $$| $$      | $$  | $$| $$  | $$| $$  >$$  $$ ^
|  $$$$$$/| $$$$$$$/| $$$$$$$$|  $$$$$$/|  $$$$$$$| $$ /$$/\  $$^
 \______/ | $$____/ |________/ \______/  \____  $$|__/|__/  \__/^
          | $$                           /$$  \ $$              ^
          | $$                          |  $$$$$$/              ^
          |__/                           \______/               ^
"

# Get current logged in user
$currentUser = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
Write-Output "Logged in user: $currentUser"

# Get hostname
$hostname = hostname
Write-Output "Hostname: $hostname"

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

# Enumerate users
$users = Get-LocalUser
foreach ($user in $users)
{
    Write-Output "Username: $($user.Name)"
    Write-Output "Description: $($user.Description)"
    Write-Output "Enabled: $($user.Enabled)"
    Write-Output "Account expires: $($user.AccountExpires)"
    Write-Output "Password never expires: $($user.PasswordNeverExpires)"
    Write-Output "-----------------------------"
}

# Run ipconfig /all
ipconfig /all


