#!/bin/bash
#
# Install common programming languages

# prepare nodejs
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -

# prepare go
sudo add-apt-repository ppa:longsleep/golang-backports

# prepare clang
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main"

# prepare mono
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
sudo apt-add-repository "deb https://download.mono-project.com/repo/ubuntu stable-bionic main"

# prepare java
sudo add-apt-repository ppa:webupd8team/java

# update index
sudo apt update

# install all
sudo apt install -y nodejs \
                    golang-go \
                    libllvm-7-ocaml-dev libllvm7 llvm-7 llvm-7-dev llvm-7-doc llvm-7-examples llvm-7-runtime \
                    clang-7 clang-tools-7 clang-7-doc libclang-common-7-dev libclang-7-dev libclang1-7 clang-format-7 python-clang-7 \
                    libfuzzer-7-dev \
                    lldb-7 \
                    lld-7 \
                    libc++-7-dev libc++abi-7-dev \
                    libomp-7-dev \
                    mono-complete \
                    oracle-java8-installer oracle-java8-set-default

# install rust
curl -sf -L https://static.rust-lang.org/rustup.sh | sh
source $HOME/.cargo/env

# after install for node
sudo npm install -g typescript
