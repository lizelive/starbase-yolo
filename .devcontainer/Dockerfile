# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.191.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}
RUN wget https://github.com/martindevans/Yolol/releases/download/11.0.0/Yolol.Emulator.Linux.zip && unzip -j /Yolol.Emulator.Linux.zip *YololEmulator -d /opt/ && rm Yolol.Emulator.Linux.zip && sudo chmod 755 /opt/YololEmulator
RUN wget https://github.com/martindevans/Yolol/releases/download/11.0.0/yasm.Linux.zip && unzip -j /yasm.Linux.zip *YololAssembler -d /opt/ && rm yasm.Linux.zip && sudo chmod 755 /opt/YololAssembler

#RUN unzip Yolol.Emulator.Linux.zip /opt
# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>


