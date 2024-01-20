# Certificate installation

# Check whether the user has administrator authorisations
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
   [Windows.Forms.MessageBox]::Show("To install a certificate you need administrator rights.", "Error", [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Error)
   return
}

# Define the URLs for the Amazon Root CA and the certificate
$amazonRootCAUrl = "https://www.amazontrust.com/repository/AmazonRootCA1.cer"
$certificateUrl = "http://crt.r2m02.amazontrust.com/r2m02.cer"

# Define the local paths for the certificates
$amazonRootCADirectory = "$env:TEMP\AmazonRootCA1.cer"
$targetDirectory = "$env:TEMP\r2m02.cer"

try {
    # Download the Amazon Root CA and the certificate
    Invoke-WebRequest -Uri $amazonRootCAUrl -OutFile $amazonRootCADirectory -UseBasicParsing -ErrorAction Stop
    Invoke-WebRequest -Uri $certificateUrl -OutFile $targetDirectory -UseBasicParsing -ErrorAction Stop

    # Import Amazon Root CA into the CA store of the current user
    Import-Certificate -FilePath $amazonRootCADirectory -CertStoreLocation Cert:\CurrentUser\CA -ErrorAction Stop
    Write-Host "Amazon Root CA has been installed in the CA store of the current user."

    # Import the certificate into the personal store of the current user
    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    $cert.Import($targetDirectory)

    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("MY", "CurrentUser") # Use "MY" for the personal store
    $store.Open("ReadWrite")
    $store.Add($cert)
    $store.Close()
    Write-Host "The certificate has been installed in the personal store of the current user."

    # Import the certificate into the machine store (LocalMachine)
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("MY", "LocalMachine") # Use "MY" for the personal store
    $store.Open("ReadWrite")
    $store.Add($cert)
    $store.Close()
    Write-Host "The certificate has been installed in the machine store (LocalMachine)."
}
catch {
    Write-Error "An error occurred while installing the certificate: $_"
}
