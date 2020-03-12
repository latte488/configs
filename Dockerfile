FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    vim \
    language-pack-ja \
    git \
    curl \
    build-essential \
    libssl-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -m docker -p docker

USER docker

WORKDIR /home/docker

# Rust言語の環境構築 
RUN curl https://sh.rustup.rs >> rustup.sh \
 && sh rustup.sh -y \
 && rm rustup.sh \
 && source ~/.cargo/env

# 文字コードを日本語とutf-8に設定
RUN echo 'export LANG=ja_JP.UTF-8' >> ~/.bashrc \
 && echo 'export LANGUAGE="ja_JP:ja"' >> ~/.bashrc

# gitの設定
RUN git config --global user.email "latte488@icloud.com" \
 && git config --global user.name "latte488" 

# vimの環境構築
RUN mkdir -p ~/.vim/pack/git-plugins/start \
 && git clone --depth 1 \
        https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale \
 && mkdir -p ~/.vim/autoload ~/.vim/bundle \
 && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
 && cd ~/.vim/bundle \
 && git clone https://github.com/dense-analysis/ale.git \
 && mkdir -p ~/.latte488/ \
 && cd ~/.latte488/ \
 && git clone https://github.com/latte488/configs.git \
 && cp ~/.latte488/configs/.vimrc ~/ 

CMD ["/bin/bash", "--login"]

