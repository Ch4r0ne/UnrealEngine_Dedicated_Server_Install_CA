# UnrealEngine Dedicated Server Install Certificate Script

This script automates the installation of a certificate required for Unreal Engine Dedicated Servers. Ensure that you have the necessary administrator privileges before running the script.

## Prerequisites

- Administrator rights are required to execute this script.

## What does this script do?

This script ensures your server's security by adding essential certificates from Amazon. Here's what it does in simple terms:

- **Step 1:** Adds certificates to `certmgr.msc`:
  - **Certificates:** "Amazon Root CA 1" and "Amazon RSA 2048 M02"
  - **Location:** "Intermediate Certification Authorities -> Certificates"

- **Step 2:** Deposits a certificate into `certlm.msc`:
  - **Certificate:** "Amazon RSA 2048 M02"
  - **Location:** "Intermediate Certification Authorities -> Certificates"

## Verification

After running the script, you can verify that the certificates are correctly installed by following these steps:

### Checking in certmgr:

1. Open `certmgr.msc`
2. Navigate to "Intermediate Certification Authorities -> Certificates".
3. Verify that "Amazon Root CA 1" and "Amazon RSA 2048 M02" are listed.

### Checking in certlm:

1. Open `certlm.msc`
2. Navigate to "Intermediate Certification Authorities -> Certificates".
3. Verify that "Amazon RSA 2048 M02" is listed.

Ensure that the certificates are correctly installed before proceeding with Unreal Engine Dedicated Server setup.

## Troubleshooting

### Verify Port and Certificates
If using a separate `netstat -aon` command, ensure that the desired port, e.g., 7777, is listening on your ASA Server. Match the PID in Task Manager with the ID shown in the netstat output, for example, "UDP 0.0.0.0:7777 *:* 17546". Activate the filter by Name in Task Manager to locate the PID associated with the process. Only when this port is actively listening will your server be listed. Otherwise, there may be an issue with the certificates.

## URLs

certificates from the following URLs:
   - Amazon Root CA URL: [https://www.amazontrust.com/repository/AmazonRootCA1.cer](https://www.amazontrust.com/repository/AmazonRootCA1.cer)
   - Amazon RSA 2048 M02 URL: [http://crt.r2m02.amazontrust.com/r2m02.cer](http://crt.r2m02.amazontrust.com/r2m02.cer)
