# ComfyUI Docker Setup

This repository contains the Docker configuration for ComfyUI with automatic model downloading.

## Quick Start

1. Clone this repository
2. Update `init-models.sh` or scripts in `/scripts/` as needed
3. Deploy with your Docker orchestrator (Coolify, Docker Compose, etc.)

## Customization

- Edit `init-models.sh` for core model changes
- Edit `scripts/download-additional-models.sh` for additional models
- Edit `scripts/install-custom-nodes.sh` for custom nodes

## Models Included

- Flux VAE (ae.safetensors)
- CLIP models (clip_l.safetensors, t5xxl_fp16.safetensors)
- Flux UNET (flux1-dev-kontext_fp8_scaled.safetensors)

## Deployment

### Method A: Git Repository (Recommended)

1. In Coolify: Create new application → "Git Repository"
2. Connect your GitHub repo
3. Set build pack to "Docker Compose"
4. Deploy

### Method B: Docker Compose

1. SSH into your Coolify server
2. Clone your repo:
   ```bash
   cd /data/coolify/services/
   git clone https://github.com/yourusername/comfyui-docker.git
   cd comfyui-docker
   ```
3. In Coolify: Create application → "Docker Compose" → paste your compose file

## Benefits

✅ Version Control: All changes tracked in Git  
✅ Easy Updates: Push to GitHub → redeploy in Coolify  
✅ Collaboration: Share with team members  
✅ Backup: Your config is safely stored in GitHub  
✅ Rollback: Easy to revert to previous versions  
✅ Modular: Separate scripts for different purposes  

## Making Changes

1. Edit files locally or on GitHub
2. Commit and push changes
3. In Coolify: Redeploy the application
4. Changes take effect on next restart

## Configuration

The setup includes:
- **ComfyUI Manager**: Automatically installed for easy node management
- **GPU Support**: NVIDIA GPU acceleration enabled
- **Persistent Storage**: Models, outputs, and custom nodes are persisted
- **Network Configuration**: Configured for Coolify with static IP
- **Automatic Model Downloads**: Core Flux models downloaded on first run
