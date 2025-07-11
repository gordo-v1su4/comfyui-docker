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

## Models & Custom Nodes Strategy

### 🎯 **Comprehensive Base + Targeted Additions**
Using `cu124-megapak` as a feature-rich foundation, then adding specific models and nodes.

### 📦 **Pre-installed in Megapak Image**:
**Models:**
- **Flux Schnell**: flux1-schnell-fp8.safetensors (fast generation)
- **SD VAE**: vae-ft-mse-840000-ema-pruned.safetensors (Stable Diffusion VAE)
- **Upscale Models**: 4x_NMKD-Siax_200k.pth, 4x_foolhardy_Remacri.pth, 8x_NMKD-Superscale_150000_G.pth
- **Embeddings**: EasyNegative.safetensors, ng_deepnegative_v1_75t.pt
- **VAE Approx**: Multiple TAESD decoders for fast previews

**Custom Nodes (30+):**
- ComfyUI-Manager, Impact Pack, ControlNet Aux, IP-Adapter Plus, ReActor
- AnimateDiff, VideoHelper, WAS Node Suite, Efficiency Nodes, KJNodes
- Custom Scripts, rgthree-comfy, Essentials, Portrait Master, and many more

### ⬇️ **Added by init-models.sh (Flux Completion)**:
- **Flux VAE**: ae.safetensors (required for Flux models)
- **CLIP Models**: clip_l.safetensors, t5xxl_fp16.safetensors (text encoders)
- **Flux Dev**: flux1-dev-kontext_fp8_scaled.safetensors (higher quality than Schnell)

### ⬇️ **Added by download-additional-models.sh (Extended Capabilities)**:
- **SDXL Base**: sd_xl_base_1.0.safetensors (high-resolution generation)
- **SDXL Refiner**: sd_xl_refiner_1.0.safetensors (detail enhancement)
- **LCM LoRA**: pytorch_lora_weights.safetensors (fast SDXL generation)
- **Real-ESRGAN**: RealESRGAN_x4plus.pth, RealESRGAN_x2plus.pth (high-quality upscaling)
- **CLIP Vision**: pytorch_model.bin (image conditioning)
- **SDXL VAE**: sdxl_vae.safetensors (SDXL compatibility)

### 🔧 **Added by install-custom-nodes.sh (Workflow-Specific Nodes)**:
- **ComfyUI-Logic**: Advanced logic and flow control
- **Workflow-Component**: Modular workflow building
- **BRIA_AI-RMBG**: Background removal capabilities
- **Image-Filters**: Advanced image processing
- **FluxTrainer**: Flux-specific training and utilities
- **Flux-Prompt-Generator**: Enhanced prompt generation for Flux
- **TiledKSampler**: Large image processing and upscaling
- **Easy-Use**: Simplified workflow nodes

### 🎯 **Workflow Support**:
This setup is optimized for advanced Flux workflows including:
- **Flux 1 Kontext Dev + Upscaler**: Complete support with all required models and nodes
- **Image-to-Image**: Full Flux ecosystem with VAE, CLIP, and UNET models
- **High-Resolution Generation**: SDXL models + advanced upscaling (Real-ESRGAN)
- **Background Processing**: BRIA AI background removal + image filters
- **Tiled Processing**: Large image handling with TiledKSampler
- **Prompt Enhancement**: Flux-specific prompt generation tools

### ✅ **Benefits of This Approach**:
- **Comprehensive Base**: Start with 30+ nodes and essential models
- **No Duplicates**: Smart addition of complementary models/nodes
- **Best of Both**: Flux Schnell (fast) + Flux Dev (quality)
- **Workflow Ready**: All dependencies for complex Flux workflows included
- **Extended Capabilities**: SDXL for high-res, specialized nodes for advanced workflows
- **Production Ready**: Megapak provides battle-tested node collection

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
- **Base Image**: `yanwk/comfyui-boot:cu124-megapak` (~24GB, comprehensive package)
- **Pre-installed**: ComfyUI + 30+ custom nodes + essential models
- **GPU Support**: NVIDIA GPU acceleration enabled (CUDA 12.4 + Python 3.12)
- **Persistent Storage**: Models, outputs, and custom nodes are persisted
- **Network Configuration**: Configured for Coolify with static IP (10.0.1.9)
- **Smart Additions**: Scripts add complementary models/nodes without conflicts
- **Production Ready**: Battle-tested megapak base + your specific requirements
