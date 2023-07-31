#!/bin/bash
# Install .NET 7.0 SDK (v7.0.100) x64 - tested on Ubuntu 22.04
sudo apt-get update -y
curl -o dotnet-sdk-7-x64.tar.gz https://download.visualstudio.microsoft.com/download/pr/253e5af8-41aa-48c6-86f1-39a51b44afdc/5bb2cb9380c5b1a7f0153e0a2775727b/dotnet-sdk-7.0.100-linux-x64.tar.gz
mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-sdk-7-x64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;
