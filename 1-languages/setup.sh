#!/bin/bash
#
# Install common programming languages

# prepare nodejs
echo -e "\e[1m[languages] \e[0m\e[96mprepare nodejs\e[0m"
tput smcup
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
tput rmcup

# prepare go
echo -e "\e[1m[languages] \e[0m\e[96mprepare go-lang\e[0m"
tput smcup
sudo add-apt-repository ppa:longsleep/golang-backports
tput rmcup

# prepare clang
echo -e "\e[1m[languages] \e[0m\e[96mprepare clang\e[0m"
tput smcup
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main"
tput rmcup

# prepare mono
echo -e "\e[1m[languages] \e[0m\e[96mprepare mono\e[0m"
tput smcup
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
sudo apt-add-repository "deb https://download.mono-project.com/repo/ubuntu stable-bionic main"
tput rmcup

# prepare haskell
echo -e "\e[1m[languages] \e[0m\e[96mprepare haskell\e[0m"
tput smcup
sudo add-apt-repository -y ppa:hvr/ghc
tput rmcup

# install all
echo -e "\e[1m[languages] \e[0m\e[96minstall everything\e[0m"
tput smcup
sudo apt update
sudo apt install -y nodejs \
                    golang-go \
                    libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime \
                    clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10 python-clang-10 \
                    libfuzzer-10-dev \
                    lldb-10 \
                    lld-10 \
                    libc++-10-dev libc++abi-10-dev \
                    libomp-10-dev \
                    mono-complete \
                    openjdk-13-jdk \
                    cabal-install-3.2 ghc-8.10.1
tput rmcup

# install stack
echo -e "\e[1m[languages] \e[0m\e[96minstall stack\e[0m"
tput smcup
curl -sSL https://get.haskellstack.org/ | sh
tput rmcup

# install rust
echo -e "\e[1m[languages] \e[0m\e[96minstall rust\e[0m"
tput smcup
curl -sf -L https://static.rust-lang.org/rustup.sh | sh
source $HOME/.cargo/env
tput rmcup

# after install for node
echo -e "\e[1m[languages] \e[0m\e[96minstall typescript\e[0m"
tput smcup
sudo npm install -g typescript
tput rmcup

# after install for haskell
cat >> ~/.bashrc <<EOF
export PATH='$HOME/.cabal/bin:/opt/cabal/3.2/bin:/opt/ghc/8.10.1/bin:$$PATH'
EOF
export PATH=~/.cabal/bin:/opt/cabal/3.2/bin:/opt/ghc/8.10.1/bin:$PATH

echo -e "\e[1m[languages] \e[0m\e[96mdone\e[0m"
