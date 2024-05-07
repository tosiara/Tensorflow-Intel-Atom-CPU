#!/bin/bash

# compatibility matrix: https://www.tensorflow.org/install/source#linux
BAZEL="6.5.0"
TF="2.16.1"
CLANG="17"
PYTHON="3.12"

apt-get install -y bazel=$BAZEL clang-$CLANG

pip install -U --user opt_einsum --break-system-packages
pip install -U --user keras_preprocessing --no-deps --break-system-packages

wget "https://github.com/tensorflow/tensorflow/archive/refs/tags/v$TF.zip"
unzip v$TF.zip 

export TF_PYTHON_VERSION=$PYTHON

cd tensorflow-$TF/
./configure
bazel build --config=opt --copt=-march=bonnell --copt=-mcx16 --copt=-mssse3 --copt=-msse3 --copt=-mno-sse4 --copt=-mno-avx -k //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

