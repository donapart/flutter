FROM ghcr.io/cirruslabs/flutter:latest

# Install linux desktop build dependencies
RUN sudo apt-get update && \
    sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev

WORKDIR /app
COPY . .

RUN flutter config --enable-linux-desktop && \
    flutter pub get

CMD ["flutter", "build", "linux", "--release"]
