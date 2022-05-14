FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=cooper
ARG DELTA_VERSION=0.12.1
ARG BAT_VERSION=0.20.0
ARG HOME=/home/${USERNAME}

ENV TERM xterm-256color

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies.
RUN apt-get update \ 
    && apt-get install -y --no-install-recommends curl gpg ca-certificates locales sudo gosu \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen

# Create the user
RUN useradd -m $USERNAME \
    && usermod -aG sudo ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers \
    && sed s/required/sufficient/g -i /etc/pam.d/chsh

# User dependencies.
WORKDIR /tmp
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        fish git stow tmux neovim ripgrep fzf zoxide fortune-mod fortunes \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # non package-manager managed
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && curl -fLo bat.deb "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" && dpkg -i bat.deb \
    && curl -fLo delta.deb "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" && dpkg -i delta.deb \
    && rm -rf /tmp/*

COPY . ${HOME}/dotfiles/
RUN chown -R ${USERNAME}:${USERNAME} ${HOME}
WORKDIR ${HOME}/dotfiles
RUN gosu ${USERNAME} bash setup.sh

USER ${USERNAME}
WORKDIR ${HOME}
ENTRYPOINT [ "/usr/bin/fish" ]