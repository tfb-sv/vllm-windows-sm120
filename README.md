<!-- markdownlint-disable MD001 MD041 -->
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/vllm-project/vllm/main/docs/assets/logos/vllm-logo-text-dark.png">
    <img alt="vLLM" src="https://raw.githubusercontent.com/vllm-project/vllm/main/docs/assets/logos/vllm-logo-text-light.png" width=55%>
  </picture>
</p>

# vLLM for Windows (sm120 / RTX 50xx)

This repository is a fork of [SystemPanic/vllm-windows @ v0.11.0](https://github.com/SystemPanic/vllm-windows/tree/v0.11.0) with additional fixes for **CUDA 12.8** source builds and **sm120 (RTX 50xx)** support.

> **NOTE:** This is an unofficial community fork. For the upstream project, see [the official vLLM repository](https://github.com/vllm-project/vllm).

## Prerequisites
Install the following:

- [Visual Studio Community](https://visualstudio.microsoft.com/downloads/) (Desktop development with C++)
- [CUDA 12.8](https://developer.nvidia.com/cuda-12-8-0-download-archive)
- [cuDNN 9.19.0](https://developer.nvidia.com/cudnn-9-19-0-download-archive)
- [Anaconda](https://www.anaconda.com/download)

## Quick Start

Open **Anaconda Prompt**.

### 1) Create a Python environment

Pick your environment name:

```
conda create -n vllm-env python=3.12 -y
conda activate vllm-env

pip install torch==2.7.1 torchvision==0.22.1 torchaudio==2.7.1 --index-url https://download.pytorch.org/whl/cu128
```

### 2) Build the vLLM wheel

Customize the build script if needed: `.quick_setup\build_vllm.bat`

```
cd vllm-windows-sm120
.\.quick_setup\build_vllm.bat
```

### 3) Install the built wheel

Use either the wheel from your build:

```
pip install .\dist\vllm-*.whl
```

Or the wheel from this repository:

```
pip install C:\Users\%USERNAME%\Downloads\vllm-*.whl
```

## Running Models

Some models may require specific library versions. For example, if you run into compatibility issues with **Qwen**, you can pin a known working `transformers` version:

```
pip uninstall -y transformers
pip install "transformers==4.57.3" tokenizers accelerate safetensors huggingface_hub
```

## Benchmark

```
python .\test\test_benchmark.py
```

### Example results

```
**With    vLLM:** 45.41 tok/s (min 45.34 / max 45.47)
**Without vLLM:** 14.35 tok/s (min 13.66 / max 14.66)
**Speed   Gain:** 45.41 / 14.35 ≈ **3.17×**
```

## Notes
- Pin dependency versions (especially **Triton** / **triton-windows**). Newer versions may install but can be incompatible.
- `VLLM_FORCE_FA3_WINDOWS_BUILD=1` (**FlastAttention-3**) is experimental on Windows and may break the build.

## Contributing
Feedback and contributions are highly valued. Issues or suggestions for improvements can be reported by opening an issue.

## License
© 2025 [Nural Ozel](https://github.com/tfb-sv).

This work is licensed under the Apache License 2.0. See `LICENSE` for details.?
