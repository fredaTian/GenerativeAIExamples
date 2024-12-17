#!/bin/bash

python -m pip install --upgrade pip

# 设置自定义的 pip 源
PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"


# 在所有子目录中查找 requirements.txt 并逐个安装
find . -name "requirements.txt" | while read req_file; do
    echo "Installing dependencies from $req_file using custom pip source $PIP_INDEX_URL..."
    pip install -r "$req_file" --index-url "$PIP_INDEX_URL" --extra-index-url "https://pypi.org/simple" --no-cache-dir
done