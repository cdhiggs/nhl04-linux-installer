FROM ubuntu:jammy

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && \
  apt install -y libwebkit2gtk-4.1-dev \
    build-essential \
    curl \
    wget \
    file \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    patchelf

# Install Rust using rustup
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y

# Set environment variables for Rust
ENV PATH="/root/.cargo/bin:${PATH}"

# Use Tauri's experimental truly portable appimage builder feature
RUN cargo install tauri-cli --git https://github.com/tauri-apps/tauri --branch feat/truly-portable-appimage

# Install NVM (Node Version Manager)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash

# Set environment variables for NVM
ENV NVM_DIR="/root/.nvm"
ENV SH="$NVM_DIR/nvm.sh"
ENV NPM_CONFIG_PREFIX="/root/.nvm/versions/node"
ENV PATH="/root/.nvm/versions/node/v22.23.0/bin:${PATH}"

# Install Node.js 22 using NVM
RUN . "$NVM_DIR/nvm.sh" && nvm install 22.23.0 && nvm alias default 22