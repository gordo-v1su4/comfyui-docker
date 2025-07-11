#!/bin/bash
set -e

echo "🚀 Starting ComfyUI initialization..."

# huggingface-hub should be pre-installed in megapak, but check anyway
if ! python3 -c "import huggingface_hub" 2>/dev/null; then
    echo "📦 Installing huggingface-hub..."
    pip install huggingface-hub
else
    echo "✅ huggingface-hub already available"
fi

# Model directories should exist from megapak, but ensure they're there
echo "📁 Ensuring model directories exist..."
mkdir -p /app/ComfyUI/models/{vae,clip,unet,checkpoints,loras,embeddings,upscale_models,controlnet}

echo "ℹ️  Using cu124-megapak: Comprehensive base with 30+ custom nodes and essential models"
echo "📋 Megapak includes: Flux Schnell, SD VAE, upscale models, embeddings, 30+ custom nodes"

# Download additional Flux models (complement what's in megapak)
if [ ! -f "/app/ComfyUI/models/vae/ae.safetensors" ]; then
    echo "⬇️ Downloading additional Flux models to complement megapak..."
    echo "   Megapak includes: Flux Schnell checkpoint"
    echo "   Adding: Flux VAE, CLIP models, and Flux Dev UNET"

    python3 -c "
from huggingface_hub import hf_hub_download
import os

print('Downloading Flux VAE (required for Flux models)...')
hf_hub_download(
    repo_id='Comfy-Org/Lumina_Image_2.0_Repackaged',
    filename='ae.safetensors',
    subfolder='split_files/vae',
    local_dir='/app/ComfyUI/models/vae'
)

print('Downloading CLIP models (required for Flux)...')
hf_hub_download(
    repo_id='comfyanonymous/flux_text_encoders',
    filename='clip_l.safetensors',
    local_dir='/app/ComfyUI/models/clip'
)

hf_hub_download(
    repo_id='comfyanonymous/flux_text_encoders',
    filename='t5xxl_fp16.safetensors',
    local_dir='/app/ComfyUI/models/clip'
)

print('Downloading Flux Dev UNET (higher quality than Schnell)...')
hf_hub_download(
    repo_id='Comfy-Org/flux1-kontext-dev_ComfyUI',
    filename='flux1-dev-kontext_fp8_scaled.safetensors',
    subfolder='split_files/diffusion_models',
    local_dir='/app/ComfyUI/models/unet'
)

# Download additional Flux models for workflow compatibility
print('Downloading additional Flux models for workflow support...')
try:
    # Try to download Flux Dev full model as checkpoint (some workflows expect this format)
    hf_hub_download(
        repo_id='black-forest-labs/FLUX.1-dev',
        filename='flux1-dev.safetensors',
        local_dir='/app/ComfyUI/models/checkpoints'
    )
    print('✅ Flux Dev checkpoint downloaded')
except Exception as e:
    print(f'ℹ️  Flux Dev checkpoint not available or requires authentication: {e}')
    print('   Using UNET format instead (already downloaded)')

print('✅ Additional Flux models downloaded!')
print('📋 Complete Flux setup now available:')
print('   🚀 Flux Schnell (from megapak): Fast generation')
print('   🎨 Flux Dev (downloaded): High-quality generation')
print('   🔧 Flux VAE: ae.safetensors')
print('   📝 CLIP models: clip_l.safetensors, t5xxl_fp16.safetensors')
print('   ⬆️  Upscale models (from megapak): 4x_NMKD-Siax_200k, etc.')
print('   🎭 Embeddings (from megapak): EasyNegative, etc.')
"
else
    echo "✅ Additional Flux models already exist."
    echo "📋 Complete Flux setup available: Schnell (fast) + Dev (quality)"
fi

# ComfyUI Manager (pre-installed in megapak)
if [ ! -d "/app/ComfyUI/custom_nodes/ComfyUI-Manager" ]; then
    echo "📦 Installing ComfyUI Manager..."
    cd /app/ComfyUI/custom_nodes
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
    echo "✅ ComfyUI Manager installed!"
else
    echo "✅ ComfyUI Manager already available (from megapak)"
fi

# Run additional model downloads if script exists
if [ -f "/scripts/download-additional-models.sh" ]; then
    echo "📦 Running additional model downloads..."
    /scripts/download-additional-models.sh
fi

# Install custom nodes if script exists
if [ -f "/scripts/install-custom-nodes.sh" ]; then
    echo "📦 Installing custom nodes..."
    /scripts/install-custom-nodes.sh
fi

echo "🎉 Initialization complete!"
