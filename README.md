
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

## Vulnerabilities and Fixes in the Patched Version

The latest version of Pixi (`heshaam/pixi:latest`) is vulnerable to the following security issues:

1. **API1**: Unauthorized users can delete pictures belonging to other users.
2. **API2**: Insufficient authorization checks allow non-admin users to delete other users and view all users.
3. **API3**: Sensitive user information, including passwords, is included in JWT tokens.
4. **API6**: Users can escalate privileges to become an admin.
5. **API7**: The server leaks internal details through the `X-Powered-By` header.
6. **API10**: Full user details, including passwords, are logged, leading to potential information disclosure.

The patched version (`heshaam/pixi:patched`) addresses these issues as follows:

- **API1**: Added checks to ensure only the owner of the picture can delete it.
- **API2**: Implemented stricter role-based access control to ensure that only admin users can delete other users or access the full user list.
- **API3**: JWT tokens no longer include sensitive user information such as passwords.
- **API6**: Users cannot escalate privileges by modifying the `is_admin` flag.
- **API7**: The `X-Powered-By` header has been removed to avoid leaking internal implementation details.
- **API10**: Logging has been sanitized to avoid including sensitive information.
