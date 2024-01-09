#!/bin/bash
# Install Install .NET 8.0 SDK (v8.0.101) x64 - tested on Ubuntu 22.04
sudo apt-get update -y
curl -o dotnet-sdk-8-x64.tar.gz https://download.visualstudio.microsoft.com/download/pr/9454f7dc-b98e-4a64-a96d-4eb08c7b6e66/da76f9c6bc4276332b587b771243ae34/dotnet-sdk-8.0.101-linux-x64.tar.gz
mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-sdk-8-x64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;
