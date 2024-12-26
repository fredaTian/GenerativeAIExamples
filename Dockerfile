# # 使用 nvidia/pytorch 镜像作为基础镜像
# FROM nvcr.io/nvidia/pytorch:24.09-py3

# 使用我定义的docker作为基础镜像
FROM ngc_pytorch_nemo_gai:24.12

# 设置工作目录
WORKDIR /workspace

# 安装系统依赖（如果 faiss-cpu 需要）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 依赖
RUN pip install --upgrade pip

RUN pip install \
    langchain==0.2.5 \
    langchain_community==0.2.5 \
    faiss-cpu==1.8.0 \
    langchain-nvidia-ai-endpoints==0.1.2 \
    pydantic \
    transformers \ # Llama 模型通常依赖 transformers
    sentencepiece # 一些 Llama 模型需要 sentencepiece

# 如果需要安装特定的 llama 模型库，例如 llama-cpp-python
# 可以取消注释以下行，并根据需要修改版本号
# RUN pip install llama-cpp-python

# # 复制你的代码（如果需要）
# COPY codes /workspace/codes
# COPY git_repo /workspace/git_repo

# 设置环境变量（可选）
# ENV ENV_VAR_NAME=value

# 设置容器启动时执行的命令（可选，根据你的 docker-compose 文件）
# CMD ["sh", "-c", "nvidia-smi"]

# 或者使用 entrypoint 和 command 的方式更灵活
# ENTRYPOINT ["sh", "-c"]
# CMD ["nvidia-smi"]

# 设置默认命令，防止容器启动后立即退出，可以根据实际情况修改
CMD ["/bin/bash"]