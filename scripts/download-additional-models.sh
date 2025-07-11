#!/bin/bash
# Add your additional model downloads here (beyond what's in megapak)
echo "📦 Downloading additional models..."
echo "ℹ️  Megapak already includes: Flux Schnell, SD VAE, upscale models, embeddings"

# Download models that complement the megapak collection
python3 -c "
from huggingface_hub import hf_hub_download
import os

# Note: Flux Schnell and SD VAE are already in megapak, so we add different models

# Download additional upscaler models for Flux workflows
print('Downloading additional upscaler models for Flux workflows...')

# Real-ESRGAN models for high-quality upscaling
hf_hub_download(
    repo_id='ai-forever/Real-ESRGAN',
    filename='RealESRGAN_x4plus.pth',
    local_dir='/app/ComfyUI/models/upscale_models'
)

hf_hub_download(
    repo_id='ai-forever/Real-ESRGAN',
    filename='RealESRGAN_x2plus.pth',
    local_dir='/app/ComfyUI/models/upscale_models'
)

# ESRGAN models commonly used in workflows
hf_hub_download(
    repo_id='uwg/upscaler',
    filename='ESRGAN/4x_NMKD-Superscale_150000_G.pth',
    local_dir='/app/ComfyUI/models/upscale_models'
)

# Download SDXL model for high-resolution generation
print('Downloading SDXL Base model...')
hf_hub_download(
    repo_id='stabilityai/stable-diffusion-xl-base-1.0',
    filename='sd_xl_base_1.0.safetensors',
    local_dir='/app/ComfyUI/models/checkpoints'
)

# Download SDXL Refiner
print('Downloading SDXL Refiner...')
hf_hub_download(
    repo_id='stabilityai/stable-diffusion-xl-refiner-1.0',
    filename='sd_xl_refiner_1.0.safetensors',
    local_dir='/app/ComfyUI/models/checkpoints'
)

# Download additional LoRA models
print('Downloading useful LoRA models...')
hf_hub_download(
    repo_id='latent-consistency/lcm-lora-sdxl',
    filename='pytorch_lora_weights.safetensors',
    local_dir='/app/ComfyUI/models/loras',
    local_dir_use_symlinks=False
)

print('✅ Additional models downloaded!')
print('📋 Available models:')
print('   🚀 Flux Schnell (megapak): Fast generation')
print('   🎨 Flux Dev (init script): High-quality generation')
print('   🖼️  SDXL Base + Refiner: High-resolution generation')
print('   ⚡ LCM LoRA: Fast SDXL generation')
print('   📈 Real-ESRGAN: High-quality upscaling')
print('   🔧 Additional ESRGAN models: Various upscaling options')
"

# Download models specifically for Flux Kontext workflows
echo "📦 Downloading Flux workflow-specific models..."
python3 -c "
from huggingface_hub import hf_hub_download
import os

# Download additional models that might be needed for Flux workflows
print('Downloading workflow-specific models...')

# Download CLIP Vision model (often needed for image conditioning)
try:
    hf_hub_download(
        repo_id='openai/clip-vit-large-patch14',
        filename='pytorch_model.bin',
        local_dir='/app/ComfyUI/models/clip_vision'
    )
    print('✅ CLIP Vision model downloaded')
except Exception as e:
    print(f'ℹ️  CLIP Vision model download failed: {e}')

# Download additional VAE models for compatibility
try:
    hf_hub_download(
        repo_id='madebyollin/sdxl-vae-fp16-fix',
        filename='sdxl_vae.safetensors',
        local_dir='/app/ComfyUI/models/vae'
    )
    print('✅ SDXL VAE downloaded')
except Exception as e:
    print(f'ℹ️  SDXL VAE download failed: {e}')

print('✅ Workflow-specific models processed')
"

# Uncomment to download more specific models:
# python3 -c "
# from huggingface_hub import hf_hub_download
#
# # Example: Download specific checkpoint
# hf_hub_download(
#     repo_id='runwayml/stable-diffusion-v1-5',
#     filename='v1-5-pruned-emaonly.safetensors',
#     local_dir='/app/ComfyUI/models/checkpoints'
# )
#
# # Example: Download ControlNet model
# hf_hub_download(
#     repo_id='lllyasviel/ControlNet-v1-1',
#     filename='control_v11p_sd15_canny.pth',
#     local_dir='/app/ComfyUI/models/controlnet'
# )
# "

echo "✅ Additional models downloaded!"
