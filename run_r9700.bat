@echo off
cd /d "%~dp0"
call venv\Scripts\activate.bat
set HIP_VISIBLE_DEVICES=0
set CUDA_VISIBLE_DEVICES=0
set MIOPEN_FIND_MODE=FAST
set PYTORCH_HIP_ALLOC_CONF=expandable_segments:True
python main.py --listen 0.0.0.0 --port 8188 --cuda-device 0 --reserve-vram 3 --use-pytorch-cross-attention --disable-smart-memory --bf16-vae
