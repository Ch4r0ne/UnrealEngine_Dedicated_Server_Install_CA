# UnrealEngine_Dedicated_Server_Install_CA

## Certificate Installation Script

This script automates the installation of a certificate required for Unreal Engine Dedicated Servers. Ensure that you have the necessary administrator privileges before running the script.

### Prerequisites
- Administrator rights are required to execute this script.

### Instructions

#### 1. Download Certificates
```powershell
# Define the URLs for the Amazon Root CA and the certificate
$amazonRootCAUrl = "https://www.amazontrust.com/repository/AmazonRootCA1.cer"
$certificateUrl = "http://crt.r2m02.amazontrust.com/r2m02.cer"

# Define the local paths for the certificates
$amazonRootCADirectory = "$env:TEMP\AmazonRootCA1.cer"
$targetDirectory = "$env:TEMP\r2m02.cer"

# Download the Amazon Root CA and the certificate
Invoke-WebRequest -Uri $amazonRootCAUrl -OutFile $amazonRootCADirectory -UseBasicParsing -ErrorAction Stop
Invoke-WebRequest -Uri $certificateUrl -OutFile $targetDirectory -UseBasicParsing -ErrorAction Stop
```

#### 2. Install Amazon Root CA
```powershell
# Import Amazon Root CA into the CA store of the current user
Import-Certificate -FilePath $amazonRootCADirectory -CertStoreLocation Cert:\CurrentUser\CA -ErrorAction Stop
Write-Host "Amazon Root CA has been installed in the CA store of the current user."
```

#### 3. Install Certificate (Personal Store)
```powershell
# Import the certificate into the personal store of the current user
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import($targetDirectory)

$store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "CurrentUser")
$store.Open("ReadWrite")
$store.Add($cert)
$store.Close()
Write-Host "The certificate has been installed in the personal store of the current user."
```

#### 4. Install Certificate (Machine Store)
```powershell
# Import the certificate into the machine store (LocalMachine)
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store("MY", "LocalMachine")
$store.Open("ReadWrite")
$store.Add($cert)
$store.Close()
Write-Host "The certificate has been installed in the machine store (LocalMachine)."
```
