# ComfyUI ROCm Setup Guide — AMD Radeon AI PRO R9700 (Windows 11)

This document describes how to set up ComfyUI with native ROCm support on Windows 11 for the AMD Radeon AI PRO R9700 (gfx1201, 32 GB).

## Prerequisites

- **Windows 11 64-bit**
- **AMD Radeon AI PRO R9700** with latest Adrenalin/SI driver installed
- **Git** (`winget install Git.Git`)
- **Python 3.13 64-bit** (`winget install Python.Python.3.13`)

## Step-by-Step Setup

### 1. Clone ComfyUI

```powershell
cd e:\Dev
git clone https://github.com/Comfy-Org/ComfyUI.git
cd ComfyUI
```

### 2. Create Python 3.13 Virtual Environment

```powershell
py -3.13 -m venv venv
.\venv\Scripts\activate
pip install --upgrade pip wheel
```

### 3. Install ROCm PyTorch (Windows, gfx1201)

```powershell
pip install --index-url https://stable.repo.amd.com/rocm/whl-next/ `
    "torch[device-gfx1201]==2.13.0+rocm10.0.0" `
    "torchvision[device-gfx1201]==0.28.0+rocm10.0.0" `
    "torchaudio==2.11.0.2+rocm10.0.0"
```

> **Note:** This downloads ~2 GB. Use `device-gfx1201` (not `device-all`) for a smaller, R9700-specific install.

### 4. Install ComfyUI Dependencies

```powershell
pip install -r requirements.txt
```

### 5. Verify GPU Detection

```powershell
python -c "import torch; print('version:', torch.__version__); print('cuda:', torch.cuda.is_available()); print('device:', torch.cuda.get_device_name(0))"
```

Expected output:
```
version: 2.13.0+rocm10.0.0
cuda: True
device: AMD Radeon AI PRO R9700
```

### 6. Launch ComfyUI

Use `run_r9700.bat` or manually:

```powershell
.\venv\Scripts\activate
$env:HIP_VISIBLE_DEVICES = "0"
$env:CUDA_VISIBLE_DEVICES = "0"
$env:MIOPEN_FIND_MODE = "FAST"
python main.py --cuda-device 0 --highvram --reserve-vram 2 --use-pytorch-cross-attention --bf16-vae --auto-launch
```

Open http://127.0.0.1:8188 in your browser.

## Migrating Models from ComfyUI Desktop

If you have models from ComfyUI Desktop at:
`C:\Users\<user>\AppData\Local\Comfy-Desktop\ComfyUI-Shared\models`

Run `copy_models.ps1` (included in this repo) or manually copy to `e:\Dev\ComfyUI\models\`.

## Updating

```powershell
cd e:\Dev\ComfyUI
git pull
.\venv\Scripts\activate
pip install -r requirements.txt
```

## Key Details

| Item | Value |
|------|-------|
| GPU | AMD Radeon AI PRO R9700 (gfx1201) |
| VRAM | 32 GB |
| Python | 3.13.15 |
| PyTorch | 2.13.0+rocm10.0.0 |
| ROCm | 10.0.0 |
| ComfyUI | 0.36.0 |

## Notes

- **No WSL or Docker needed** — native Windows ROCm works directly
- **No `HSA_OVERRIDE_GFX_VERSION`** — gfx1201 is natively supported in ROCm 10.0
- **No separate HIP SDK** — pip wheels include everything
- First GPU kernel run may be slow (MIOPEN caching)
- Use `--highvram` for 32 GB GPU; use `--lowvram` if running out of memory
