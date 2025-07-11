#!/bin/bash
set -e

echo "🚀 Starting ComfyUI initialization..."

# Install huggingface-hub if not present
if ! python3 -c "import huggingface_hub" 2>/dev/null; then
    echo "📦 Installing huggingface-hub..."
    pip install huggingface-hub
fi

# Create model directories
echo "📁 Creating model directories..."
mkdir -p /app/ComfyUI/models/{vae,clip,unet,checkpoints,loras,embeddings,upscale_models,controlnet}

# Download core models
if [ ! -f "/app/ComfyUI/models/vae/ae.safetensors" ]; then
    echo "⬇️ Downloading core models..."
    
    python3 -c "
from huggingface_hub import hf_hub_download
import os

print('Downloading VAE...')
hf_hub_download(
    repo_id='Comfy-Org/Lumina_Image_2.0_Repackaged',
    filename='ae.safetensors',
    subfolder='split_files/vae',
    local_dir='/app/ComfyUI/models/vae'
)

print('Downloading CLIP models...')
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

print('Downloading UNET model...')
hf_hub_download(
    repo_id='Comfy-Org/flux1-kontext-dev_ComfyUI',
    filename='flux1-dev-kontext_fp8_scaled.safetensors',
    subfolder='split_files/diffusion_models',
    local_dir='/app/ComfyUI/models/unet'
)

print('✅ Core models downloaded!')
"
else
    echo "✅ Core models already exist."
fi

# Install ComfyUI Manager
if [ ! -d "/app/ComfyUI/custom_nodes/ComfyUI-Manager" ]; then
    echo "📦 Installing ComfyUI Manager..."
    cd /app/ComfyUI/custom_nodes
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
    echo "✅ ComfyUI Manager installed!"
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
