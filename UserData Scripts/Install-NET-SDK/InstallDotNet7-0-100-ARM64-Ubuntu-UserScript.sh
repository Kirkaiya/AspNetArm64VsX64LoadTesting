#!/bin/bash
# Install .NET 7.0 SDK (v7.0.100) ARM64 - tested on Ubuntu 22.04
sudo apt-get update -y
curl -o dotnet-sdk-7-arm64.tar.gz https://download.visualstudio.microsoft.com/download/pr/47337472-c910-4815-9d9b-80e1a30fcf16/14847f6a51a6a7e53a859d4a17edc311/dotnet-sdk-7.0.100-linux-arm64.tar.gz
mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-sdk-7-arm64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;
