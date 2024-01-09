#!/bin/bash
# Install .NET 8.0 SDK (v8.0.101) ARM64 - tested on Ubuntu 22.04
sudo apt-get update -y
curl -o dotnet-sdk-8-arm64.tar.gz https://download.visualstudio.microsoft.com/download/pr/092bec24-9cad-421d-9b43-458b3a7549aa/84280dbd1eef750f9ed1625339235c22/dotnet-sdk-8.0.101-linux-arm64.tar.gz
mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-sdk-8-arm64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;
