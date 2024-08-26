
# Pixi API Local Demo Environment

## Introduction

This repository provides a setup for creating a local demo environment to test the Pixi API deployment using 42Crunch. The purpose is to demonstrate how 42Crunch can identify security vulnerabilities in the Pixi API, including those listed in the OWASP Top 10, and then show how these issues can be mitigated by switching to a patched version.

## Purpose

The demo environment is designed to showcase the security testing capabilities of 42Crunch by:
1. Deploying a vulnerable version of the Pixi API to identify and analyze security issues.
2. Switching to a patched version of the Pixi API to validate the effectiveness of the fixes and improvements.
3. Using 42Crunch to scan and report on the security posture of the API before and after applying the patches.

## Available Architectures

This repository supports three deployment architectures:

1. **Standard Deployment**: Deploy the latest, vulnerable version of the Pixi API.
2. **Patched Deployment**: Deploy a patched version of the Pixi API with security fixes.
3. **Firewalled Deployment**: Deploy the Pixi API with an API firewall to add an extra layer of protection.

## Deployment Instructions

### Standard Deployment

This deployment uses the latest version of the Pixi API, which is intentionally vulnerable to several security issues, making it ideal for testing with 42Crunch.

**Docker Compose Command:**
```bash
docker-compose -f docker-compose.yaml up
```

**Configuration:**
- **API Image**: `heshaam/pixi:latest`
- **Ports**: Exposes port `8090` for API access.

### Patched Deployment

Deploy this version after identifying vulnerabilities in the standard deployment. The patched version contains fixes for the vulnerabilities identified by 42Crunch.

**Docker Compose Command:**
```bash
docker-compose -f docker-compose-patched.yaml up
```

**Configuration:**
- **API Image**: `heshaam/pixi:patched`
- **Ports**: Exposes port `8090` for API access.

### Firewalled Deployment

For added security, deploy the Pixi API with an integrated API firewall. This setup helps demonstrate how 42Crunch can secure an API in real-time.

**Docker Compose Command:**
```bash
docker-compose -f docker-compose-firewalled.yaml up
```

**Configuration:**
- **API Image**: `heshaam/pixi:latest`
- **API Firewall Image**: `42crunch/apifirewall:latest`
- **Ports**: 
  - API Firewall listens on port `8080`.
  - API service listens on port `8090`.

**Important:** Before deploying the firewall, **update the `PROTECTION_TOKEN`** value in the `.env` file. This token is required for the firewall to function properly and connect to the 42Crunch Platform.

## Demonstrating 42Crunch Testing Capabilities

### Step 1: Scan the Vulnerable API

Deploy the standard version of the Pixi API and use 42Crunch to perform a full security scan. The scan will identify numerous vulnerabilities, many of which correspond to the OWASP Top 10 API Security Risks.

### Step 2: Analyze the Results

Review the findings from the 42Crunch scan. The report will highlight specific security flaws, including those related to:
- **Broken Object Level Authorization (API1)**
- **Broken User Authentication (API2)**
- **Sensitive Data Exposure (API3)**
- **Lack of Resource & Rate Limiting (API4)**
- **Broken Function Level Authorization (API5)**
- **Privilege Escalation (API6)**
- **Information Exposure Through Headers (API7)**
- **Insufficient Logging & Monitoring (API10)**

### Step 3: Apply the Patch

Switch to the patched deployment to address the vulnerabilities identified in the previous step. Deploy the patched version and run another 42Crunch scan.

### Step 4: Validate the Fixes

Analyze the new scan results. You should observe a significant reduction in the number of vulnerabilities, demonstrating the effectiveness of the patches. This step validates that the security issues identified by 42Crunch have been successfully resolved.

### Step 5: Enhance Security with API Firewall

For further protection, deploy the firewalled version of the Pixi API. This setup showcases how 42Crunch’s API firewall can provide real-time protection against API threats.

## Vulnerabilities and Fixes in the Patched Version

The vulnerabilities identified in the Pixi API (latest version) and their corresponding fixes in the patched version are as follows:

1. **API1 (Broken Object Level Authorization):** Unauthorized users can delete pictures belonging to other users.  
   **Fix:** Added checks to ensure only the owner of the picture can delete it.

2. **API2 (Broken User Authentication):** Insufficient authorization checks allow non-admin users to delete other users and view all users.  
   **Fix:** Implemented stricter role-based access control to ensure that only admin users can delete other users or access the full user list.

3. **API3 (Sensitive Data Exposure):** Sensitive user information, including passwords, is included in JWT tokens.  
   **Fix:** JWT tokens no longer include sensitive user information such as passwords.

4. **API4 (Lack of Resource & Rate Limiting):** The server lacks rate limiting, potentially allowing a denial of service attack by overwhelming the server with requests.  
   **Fix:** Implemented rate limiting and restricted the number of requests a user can make in a given time period.

5. **API5 (Broken Function Level Authorization):** Users can perform actions beyond their intended permissions due to lack of role-based access control, such as generating tokens with improper parameters.  
   **Fix:** Enforced proper role-based access control to restrict access to sensitive operations.

6. **API6 (Privilege Escalation):** Users can escalate privileges to become an admin by modifying the `is_admin` flag.  
   **Fix:** Users cannot escalate privileges by modifying the `is_admin` flag.

7. **API7 (Information Exposure Through Headers):** The server leaks internal details through the `X-Powered-By` header.  
   **Fix:** The `X-Powered-By` header has been removed to avoid leaking internal implementation details.

8. **API10 (Insufficient Logging & Monitoring):** Full user details, including passwords, are logged, leading to potential information disclosure.  
   **Fix:** Logging has been sanitized to avoid including sensitive information.

These vulnerabilities were identified and fixed in the `heshaam/pixi:patched` version. Use the patched version to avoid these security issues.

