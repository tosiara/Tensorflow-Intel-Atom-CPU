FROM ubuntu:24.04

RUN apt-get update && apt-get install -y wget unzip apt-transport-https curl gnupg patchelf -y && \
	curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg && \
	mv bazel-archive-keyring.gpg /usr/share/keyrings && \
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && apt-get update

RUN apt-get install -y python3-dev python3-pip python3-numpy python3-wheel python3-packaging python3-requests python-is-python3

COPY build-atom.sh /

