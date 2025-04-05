#!/bin/bash

MODEL_CACHE="$HF_CACHE"

docker run --gpus all \
  -v "$MODEL_CACHE:/root/.cache/huggingface" \
  -e HF_TOKEN="$HF_TOKEN" \
  --rm \
  stable-virtual-camera
