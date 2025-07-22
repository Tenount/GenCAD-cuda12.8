# install pixi on host
# curl -fsSL https://pixi.sh/install.sh | sh

# pixi init --import environment.yml

# https://pixi.sh/dev/python/pytorch/#pytorch-index

# xvfb-run --server-args="-screen 0 2048x2048x24" python inference_gencad.py -image_path data/images -export_img

pixi shell -e gpu

python -c "import torch; print(f'cuda.is_available: {torch.cuda.is_available()}')"
python -c "import torch; print('torch:', torch.__version__)"

pixi info

