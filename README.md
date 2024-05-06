# NO AVX, NO SSE4, NO CUDA

**Wheel Specs**  

CPU: Intel(R) Atom(TM) CPU D2550 @ 1.86GHz (bonnell)

| TF  | OS | Py | SSE3 | SSE4.1 | SSE4.2 | AVX |
| --- | -- | -- | ---- | ------ | ------ | --- |
|2.11.1 | Ubuntu 20.04 | 3.8  | ✅ | ❌ | ❌ | ❌ |
|2.13.0 | Ubuntu 20.04 | 3.8  | ✅ | ❌ | ❌ | ❌ |

Compiled binary wheel added to Releases

# How to compile

This page explains how to build from scratch Tensorflow
_From https://www.tensorflow.org/install/source and https://github.com/yaroslavvb/tensorflow-community-wheels_

To get you CPU Type: 

`grep -m 1 'model name' /proc/cpuinfo`

To get your march: 

`gcc -march=native -Q --help=target|grep march`

Example bazel flags for bonnel CPU:

`--config=opt --copt=-march=bonnell --copt=-mcx16 --copt=-mssse3 --copt=-msse3 --copt=-mno-sse4 --copt=-mno-avx`

### Prereqs

```
apt-get update
apt install apt-transport-https curl gnupg patchelf -y
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list

apt-get update
apt-get install bazel=5.3.0

apt install python3-dev python3-pip
pip install -U --user pip numpy wheel packaging requests opt_einsum
pip install -U --user keras_preprocessing --no-deps
```

### Build Tensorflow

```
bazel build --config=opt --copt=-march=bonnell --copt=-mcx16 --copt=-mssse3 --copt=-msse3 --copt=-mno-sse4 --copt=-mno-avx -k //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
```
