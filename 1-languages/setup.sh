#!/bin/bash
#
# Install common programming languages

# prepare nodejs
echo -e "\e[1m[languages] \e[0m\e[96mprepare nodejs\e[0m"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

# prepare go
echo -e "\e[1m[languages] \e[0m\e[96mprepare go-lang\e[0m"
if [[ $(lsb_release -cs) = "focal" ]]; then
    sudo apt-get install -y golang-1.14
else
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get install -y golang-go
fi

# prepare clang
echo -e "\e[1m[languages] \e[0m\e[96mprepare clang\e[0m"
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb http://apt.llvm.org/$(lsb_release -cs)/ llvm-toolchain-$(lsb_release -cs)-12 main"

# prepare mono
echo -e "\e[1m[languages] \e[0m\e[96mprepare mono\e[0m"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
sudo apt-add-repository "deb https://download.mono-project.com/repo/ubuntu stable-$(lsb_release -cs) main"

# prepare haskell
echo -e "\e[1m[languages] \e[0m\e[96mprepare haskell\e[0m"
sudo add-apt-repository -y ppa:hvr/ghc

# install all
echo -e "\e[1m[languages] \e[0m\e[96minstall everything\e[0m"
sudo apt-get update
sudo apt-get install -y nodejs \
                    libllvm-12-ocaml-dev libllvm12 llvm-12 llvm-12-dev llvm-12-doc llvm-12-examples llvm-12-runtime \
                    clang-12 clang-tools-12 clang-12-doc libclang-common-12-dev libclang-12-dev libclang1-12 clang-format-12 python-clang-12 clangd-12 \
                    libfuzzer-12-dev \
                    lldb-12 \
                    lld-12 \
                    libc++-12-dev libc++abi-12-dev \
                    libomp-12-dev \
                    libclc-12-dev \
                    mono-complete \
                    openjdk-13-jdk \
                    cabal-install-3.4 ghc-9.0.1

# install stack
echo -e "\e[1m[languages] \e[0m\e[96minstall stack\e[0m"
curl -sSL https://get.haskellstack.org/ | sh

# install rust
echo -e "\e[1m[languages] \e[0m\e[96minstall rust\e[0m"
curl -sf -L https://static.rust-lang.org/rustup.sh | sh
source $HOME/.cargo/env

# after install for node
echo -e "\e[1m[languages] \e[0m\e[96minstall typescript\e[0m"
sudo npm install -g typescript

# after install for haskell
cat >> ~/.bashrc << "EOF"
export PATH="~/.cabal/bin:/opt/cabal/3.4/bin:/opt/ghc/9.0.1/bin:$PATH"
EOF
export PATH=~/.cabal/bin:/opt/cabal/3.4/bin:/opt/ghc/9.0.1/bin:$PATH

echo -e "\e[1m[languages] \e[0m\e[96mdone\e[0m"
