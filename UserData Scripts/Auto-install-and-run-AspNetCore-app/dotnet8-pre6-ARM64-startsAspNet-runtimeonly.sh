#!/bin/bash
# Install ASP.NET Core Runtime 8.0 preview 6 for ARM64 then run sample asp.net core app - tested on Ubuntu 22.04
sudo apt-get update -y
curl -o dotnet-aspnet-8-arm64.tar.gz https://download.visualstudio.microsoft.com/download/pr/ffeb1444-c55b-4689-9def-e641851fe9aa/44b8b52675cc384a8ec44004e9581ba2/aspnetcore-runtime-8.0.0-preview.6.23329.11-linux-arm64.tar.gz

mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-aspnet-8-arm64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;
curl -o performancetestaspnet8.zip kirk-docs-share.s3-us-west-2.amazonaws.com/performancetestaspnet8.zip
sudo apt install unzip -y
sudo unzip performancetestaspnet8.zip -d aspnetmvc
sudo chmod +rwx aspnetmvc
sudo /usr/bin/dotnet/dotnet aspnetmvc/EC2BenchmarkingAspNet8.dll --urls=http://0.0.0.0:5000