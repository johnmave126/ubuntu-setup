#!/bin/bash
#
# Install common programming languages

# prepare nodejs
echo -e "\e[1m[languages] \e[0m\e[96mprepare nodejs\e[0m"
tput smcup
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
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
sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main"
tput rmcup

# prepare mono
echo -e "\e[1m[languages] \e[0m\e[96mprepare mono\e[0m"
tput smcup
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
sudo apt-add-repository "deb https://download.mono-project.com/repo/ubuntu stable-bionic main"
tput rmcup

# prepare java
echo -e "\e[1m[languages] \e[0m\e[96mprepare mono\e[0m"
tput smcup
sudo add-apt-repository ppa:webupd8team/javaecho
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
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
                    libllvm-7-ocaml-dev libllvm7 llvm-7 llvm-7-dev llvm-7-doc llvm-7-examples llvm-7-runtime \
                    clang-7 clang-tools-7 clang-7-doc libclang-common-7-dev libclang-7-dev libclang1-7 clang-format-7 python-clang-7 \
                    libfuzzer-7-dev \
                    lldb-7 \
                    lld-7 \
                    libc++-7-dev libc++abi-7-dev \
                    libomp-7-dev \
                    mono-complete \
                    oracle-java8-installer oracle-java8-set-default \
                    cabal-install-1.22 ghc-7.10.3
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
export PATH='$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH'
EOF
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH

echo -e "\e[1m[languages] \e[0m\e[96mdone\e[0m"