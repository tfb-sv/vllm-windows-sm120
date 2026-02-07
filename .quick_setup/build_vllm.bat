@echo off
setlocal

REM ==== LONG PATH SUPPORT ====

git config --global core.longpaths true
reg add HKLM\SYSTEM\CurrentControlSet\Control\FileSystem /v LongPathsEnabled /t REG_DWORD /d 1 /f

REM ==== CONFIG ====
set ENV_NAME=vllm-env
set MAIN_DIR=%~dp0\..
set CONDA_BAT=%USERPROFILE%\anaconda3\Scripts\activate.bat
set CUDA_ORIG_DIR=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8
set CUDNN_ORIG_DIR=C:\Program Files\NVIDIA\CUDNN
set VS_DIR=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat

REM ==== INIT ====
cd /d "%MAIN_DIR%"
call "%VS_DIR%" x64

REM ==== BUILD ENV ====
set DISTUTILS_USE_SDK=1
set VLLM_TARGET_DEVICE=cuda
set MAX_JOBS=12

REM ==== CUDA LINK ====
if not exist C:\CUDA (
    mklink /J C:\CUDA "%CUDA_ORIG_DIR%"
)
set CUDA_PATH=C:\CUDA
set CUDA_HOME=C:\CUDA
set PATH=%CUDA_HOME%\bin;%PATH%

REM ==== CUDNN LINK ====
if not exist C:\CUDNN (
    mklink /J C:\CUDNN "%CUDNN_ORIG_DIR%"
)
set USE_CUDNN=1
set CUDNN_LIBRARY_PATH=C:\CUDNN\v9.19\lib\12.9\x64
set CUDNN_INCLUDE_PATH=C:\CUDNN\v9.19\include\12.9

REM ==== CUDA / TORCH ====
set TORCH_CUDA_ARCH_LIST=12.0
set NVCC=nvcc
set NVCC_APPEND_FLAGS=--allow-unsupported-compiler

REM ==== CONDA ====
call "%CONDA_BAT%"
call conda activate %ENV_NAME%

REM ==== BUILD ====
python use_existing_torch.py

pip install -r requirements/build.txt
pip install -r requirements/windows.txt

rmdir /s /q build 2>nul
rmdir /s /q .deps 2>nul

pip wheel . -w dist --no-build-isolation
REM pip install . --no-build-isolation

pause
