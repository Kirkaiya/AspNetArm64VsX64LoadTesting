#!/bin/bash
# Install ASP.NET Core Runtime 7.0.5 for x64 then run sample asp.net core app - tested on Ubuntu 22.04
sudo apt-get update -y
curl -o dotnet-aspnet-7-x64.tar.gz https://download.visualstudio.microsoft.com/download/pr/b936641a-57d6-4069-bd32-280020863326/5793e00ff9e9973a01ca735479ff15b3/aspnetcore-runtime-7.0.5-linux-x64.tar.gz
mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-aspnet-7-x64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;
curl -o performancetestaspnet7.zip kirk-docs-share.s3-us-west-2.amazonaws.com/performancetestaspnet7.zip
sudo apt install unzip -y
sudo unzip performancetestaspnet7.zip -d aspnetmvc
sudo chmod +rwx aspnetmvc
sudo /usr/bin/dotnet/dotnet aspnetmvc/EC2BenchmarkingAspnet7.dll --urls=http://0.0.0.0:5000