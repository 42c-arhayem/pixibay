
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

## Getting Started

Before you begin, please make sure to clone this repository to your local machine. This is essential as all the deployment scripts, configurations, and resources are contained within the repository. Follow the steps below to clone the repository:

1. **Clone the Repository:**

   Open your terminal and run the following command to clone the repository:

   ```bash
   git clone https://github.com/42c-arhayem/pixibay.git
   ```

2. **Navigate to the Repository Directory:**

   After cloning, navigate into the cloned repository directory:

   ```bash
   cd pixibay
   ```

3. **Ensure All Necessary Files Are Present:**

   Verify that all necessary files, such as Docker Compose files, scripts, and configuration files, are present in the directory.

Now you're ready to proceed with the deployment and testing as outlined in the below.

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

