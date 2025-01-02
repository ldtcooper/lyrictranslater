# Use an official PyTorch image with CUDA for GPU support
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

# Set environment variables to avoid interactive prompts during installs
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter and Python dependencies
RUN pip install --upgrade pip && \
    pip install jupyterlab torch numpy soundfile

# Clone Demucs repository
RUN pip install -U demucs

# Install Whisper
# RUN pip install git+https://github.com/openai/whisper.git
RUN pip install -U openai-whisper

# Set working directory
WORKDIR /workspace

# Adds contents of data folder
ADD /data /data

# Expose Jupyter Notebook port
EXPOSE 8888

# Start Jupyter Lab by default
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]