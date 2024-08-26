
# Pixi API Deployment Guide

## Introduction

This guide provides instructions on deploying the Pixi API using three different architectural setups. It also details the vulnerabilities present in the latest version of the API and the fixes included in the patched version.

## Available Architectures

We offer three distinct architectures for deploying the Pixi API:

1. **Standard Deployment**: This is the basic setup with the latest version of the Pixi API.
2. **Patched Deployment**: This version includes critical security fixes for known vulnerabilities.
3. **Firewalled Deployment**: This setup adds an API firewall to protect against potential threats.

## Deployment Instructions

### Standard Deployment

This deployment uses the latest version of the Pixi API, which is vulnerable to several security issues.

**Docker Compose Command:**
```bash
docker-compose -f docker-compose.yaml up
```

**Configuration:**
- **API Image**: `heshaam/pixi:latest`
- **Ports**: Exposes port `8090` for API access.

### Patched Deployment

The patched deployment addresses several security vulnerabilities identified in the standard version.

**Docker Compose Command:**
```bash
docker-compose -f docker-compose-patched.yaml up
```

**Configuration:**
- **API Image**: `heshaam/pixi:patched`
- **Ports**: Exposes port `8090` for API access.

### Firewalled Deployment

The firewalled deployment adds an extra layer of security by integrating an API firewall to monitor and control incoming traffic.

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

## Vulnerabilities and Fixes in the Patched Version

The latest version of Pixi (`heshaam/pixi:latest`) is vulnerable to the following security issues:

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

These vulnerabilities were identified and fixed in the `heshaam/pixi:patched` version. Ensure to use the patched version to avoid these security issues.

