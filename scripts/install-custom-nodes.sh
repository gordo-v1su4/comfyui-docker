#!/bin/bash
# Install additional custom nodes (beyond the 30+ already in megapak)
echo "📦 Installing additional custom nodes..."
echo "ℹ️  Megapak already includes 30+ nodes: Impact Pack, ControlNet Aux, IP-Adapter, etc."

cd /app/ComfyUI/custom_nodes

# Check what's already installed and add complementary nodes
echo "Adding complementary nodes to megapak collection..."

# Essential nodes for Flux workflows (if not already present)
if [ ! -d "ComfyUI-Logic" ]; then
    echo "Installing logic nodes..."
    git clone https://github.com/theUpsider/ComfyUI-Logic.git
fi

if [ ! -d "ComfyUI-Workflow-Component" ]; then
    echo "Installing workflow components..."
    git clone https://github.com/11cafe/ComfyUI-Workflow-Component.git
fi

# Image processing and upscaling nodes
if [ ! -d "ComfyUI-BRIA_AI-RMBG" ]; then
    echo "Installing background removal..."
    git clone https://github.com/ZHO-ZHO-ZHO/ComfyUI-BRIA_AI-RMBG.git
fi

if [ ! -d "ComfyUI-Image-Filters" ]; then
    echo "Installing image filters..."
    git clone https://github.com/spacepxl/ComfyUI-Image-Filters.git
fi

# Flux-specific nodes and utilities
if [ ! -d "ComfyUI-FluxTrainer" ]; then
    echo "Installing Flux trainer nodes..."
    git clone https://github.com/kijai/ComfyUI-FluxTrainer.git
fi

if [ ! -d "ComfyUI-Flux-Prompt-Generator" ]; then
    echo "Installing Flux prompt generator..."
    git clone https://github.com/fairy-root/ComfyUI-Flux-Prompt-Generator.git
fi

# Advanced upscaling and post-processing
if [ ! -d "ComfyUI-TiledKSampler" ]; then
    echo "Installing tiled sampling for large images..."
    git clone https://github.com/BlenderNeko/ComfyUI_TiledKSampler.git
fi

# Workflow enhancement nodes
if [ ! -d "ComfyUI-Easy-Use" ]; then
    echo "Installing easy-use nodes..."
    git clone https://github.com/yolain/ComfyUI-Easy-Use.git
fi

# Add your specific custom nodes here:
# git clone https://github.com/your/custom-node.git

echo "✅ Additional custom nodes installed!"
echo "📋 Total nodes: 30+ from megapak + additional custom nodes"
echo "💡 Use ComfyUI Manager to browse and install more nodes as needed"
