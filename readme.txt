conda deactivate
conda env remove -n vllm-env -y

REM remove the folder "C:\Users\Nural\anaconda3\envs\vllm-env"

conda create -n vllm-env python=3.12 -y
conda activate vllm-env
pip install torch==2.7.1 torchvision==0.22.1 torchaudio==2.7.1 --index-url https://download.pytorch.org/whl/cu128

pip install "C:\Users\Nural\vllm-windows-sm120\dist\vllm-1.0.0.0.dev0+cp312-cp312-win_amd64.whl"

pip uninstall -y transformers
pip install "transformers==4.57.3" tokenizers accelerate safetensors huggingface_hub
