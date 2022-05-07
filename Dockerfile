FROM debian:bullseye
ENV DEBIAN_FRONTEND=noninteractive
ARG USERNAME=cooper
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG DELTA_VERSION=0.12.1
WORKDIR /tmp
# Install dependencies.
RUN apt-get update \ 
    && apt-get install -y --no-install-recommends curl gpg ca-certificates \ 
    # subscribe to fish upstream
    && echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list \
    && curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null \
    && apt-get update && apt-get install -y fish git stow tmux neovim ripgrep fzf zoxide fortunes fortune-mod \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # non package-manager managed
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && curl -fLo bat.deb https://github.com/sharkdp/bat/releases/download/v0.20.0/bat_0.20.0_amd64.deb && dpkg -i bat.deb \
    && curl -fLo delta.deb "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" && dpkg -i delta.deb \
    && rm -r /tmp/*
# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
COPY . /home/$USERNAME/dotfiles/
RUN sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/dotfiles/
WORKDIR /home/$USERNAME/dotfiles
RUN fish setup.fish
ENTRYPOINT [ "/usr/bin/fish" ]