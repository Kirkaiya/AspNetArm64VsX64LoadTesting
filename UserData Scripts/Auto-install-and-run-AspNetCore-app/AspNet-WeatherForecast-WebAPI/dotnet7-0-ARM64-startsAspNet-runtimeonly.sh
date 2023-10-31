#!/bin/bash
# Install ASP.NET Core Runtime 7.0.5 for ARM64 then run sample asp.net core app - tested on Ubuntu 22.04
sudo apt-get update -y
curl -o dotnet-aspnet-7-arm64.tar.gz https://download.visualstudio.microsoft.com/download/pr/565ed9fc-5ae5-4168-b08c-f4e39acf47ff/f5e3c6cc872681c08ab9aa6deb8a72c2/aspnetcore-runtime-7.0.5-linux-arm64.tar.gz
mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-aspnet-7-arm64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;
curl -o performancetestaspnet7.zip kirk-docs-share.s3-us-west-2.amazonaws.com/performancetestaspnet7.zip
sudo apt install unzip -y
sudo unzip performancetestaspnet7.zip -d aspnetmvc
sudo chmod +rwx aspnetmvc
sudo /usr/bin/dotnet/dotnet aspnetmvc/EC2BenchmarkingAspnet7.dll --urls=http://0.0.0.0:5000