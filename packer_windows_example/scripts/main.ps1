[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

winrm quickconfig -q -force

Install-PackageProvider -Name NuGet -Force
Install-Module -Name AuditPolicyDsc -Force
Install-Module -Name SecurityPolicyDsc -Force
Install-Module -Name NetworkingDsc -Force


#############################################################################
# Demo: Install IIS and create default html page
#############################################################################

Add-WindowsFeature Web-Server
Set-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value "Welcome to the Windows 2022 Datacenter Server!"

$InstallSourcePath = 'C:\Install'
$LogFilePath = 'C:\Windows\Logs'


#############################################################################
# Clean up
#############################################################################

Remove-Item -Path "$InstallSourcePath" -Recurse -Force


& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm
while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select-Object ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }