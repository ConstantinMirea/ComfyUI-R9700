# ComfyUI ROCm Setup for AMD Radeon AI PRO R9700

## Quick Start

```bash
# Launch ComfyUI with ROCm GPU acceleration
.\run_r9700.bat
```

This will open http://127.0.0.1:8188 in your browser.

## Update ComfyUI

```bash
cd e:\Dev\ComfyUI
git pull
.\venv\Scripts\activate
pip install -r requirements.txt
```

## Model Folders

Place your models in the corresponding subfolders under `models/`:

- `models/checkpoints/` - Stable Diffusion checkpoints (`.safetensors`, `.ckpt`)
- `models/vae/` - VAE models
- `models/clip/` - CLIP text encoder models
- `models/clip_vision/` - CLIP vision models
- `models/controlnet/` - ControlNet models
- `models/diffusion_models/` - Diffusion model weights (UNet)
- `models/embeddings/` - Embedding/Textual Inversion models
- `models/loras/` - LoRA models
- `models/upscale_models/` - Upscaler models

## First Test

Start with a small official template workflow:

1. Open http://127.0.0.1:8188
2. Click "Load Default" to load the default workflow
3. Use a small model like SDXL Turbo or Z-Image Turbo for testing
4. Avoid CUDA-only custom nodes initially

## Troubleshooting

- **GPU not detected**: Ensure AMD Adrenalin driver is up to date
- **Out of memory**: Reduce `--reserve-vram` value or use `--lowvram`
- **Slow first run**: MIOPEN kernel caching takes time on first run

## Technical Details

- PyTorch: 2.13.0+rocm10.0.0
- ROCm: 10.0.0
- GPU: AMD Radeon AI PRO R9700 (gfx1201, 32GB)
- Python: 3.13.15
