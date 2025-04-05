FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    ffmpeg \
    libgl1-mesa-glx \
    python3 \
    python3-pip \
    python3-dev \
    python-is-python3 && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/Stability-AI/stable-virtual-camera.git

WORKDIR /app/stable-virtual-camera

RUN pip install .

RUN git submodule update --init --recursive && \
    pip install git+https://github.com/jensenz-sai/pycolmap@543266bc316df2fe407b3a33d454b310b1641042 && \
    cd third_party/dust3r && \
    pip install -r requirements.txt && \
    cd ../..

RUN pip install roma viser \
    tyro fire ninja gradio==5.17.0 \
    einops colorama splines kornia \
    open-clip-torch diffusers \
    numpy==1.24.4 imageio[ffmpeg] \
    huggingface-hub opencv-python

EXPOSE 7860

CMD ["python", "demo_gr.py"]
