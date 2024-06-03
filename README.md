# Air-gapped IaaS Docker Image

## Overview

This Docker image is built on Photon 5.0 and is configured to facilitate enablement of vSphere with Kubernetes in an air-gapped environment. The image includes necessary tools, utilities, to deploy and manage Kubernetes node images, Tanzu packages and Tanzu CLI plugins.

## Included Utilities

- **Photon 5.0 Base Image**: Utilizes VMware Photon OS for lightweight and optimized performance.
- **Utilities and Tools**: Includes essential tools like `vim`, `curl`, `wget`, `tar`, `gzip`, `openssl`, `perl`, `nginx`, `openssh-clients`, `traceroute`, `network-config-manager`, and `jq`.
- **Carvel Tooling**: Installs Carvel tooling for managing Kubernetes resources.
- **GOVC**: Installs `govc`, a CLI for vSphere, facilitating various VMware operations.
- **Tanzu CLI**: Includes Tanzu CLI for managing Tanzu Kubernetes Grid (TKG) clusters.
- **Kubernetes Packages and Plugins**: Downloads and prepares Tanzu packages and plugins for use.
- **KUBECTL**: Installs `kubectl` v1.28 for interacting with Kubernetes clusters.
- **Data Directory**: Creates a data directory to hold repository artifacts and Kubernetes node images.

## Environment Variables

- `TANZU_CLI_CEIP_OPT_IN_PROMPT_ANSWER`: Pre-configures the CEIP prompt answer to `yes`.
- `REPO`: Sets the repository URL.
- `WORKINGDIR`: Defines the working directory for Kubernetes node images.
- `IMAGE_LIST`: Specifies the path to the image list file.

## Build Instructions

1. **Build the Docker Image**:
   ```bash
   docker build -t air-gapped-appliance .
