#!/bin/bash
# Install .NET SDK 8.0.100-rc.2 for ARM64 then run TechEmpower ASP.NET Core benchmarks and PostgreSQL DB
sudo su
apt-get update -y
curl -o dotnet-sdk-8-arm64.tar.gz https://download.visualstudio.microsoft.com/download/pr/0247681a-1a4a-4a32-a1a6-4149d56af27e/5bcbf1d8189c2649b16d27f5199e04a4/dotnet-sdk-8.0.100-rc.2.23502.2-linux-arm64.tar.gz
mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-8-arm64.tar.gz -C $HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

dotnet tool install —global dotnet-ef —version 7.0.12

export PATH="$PATH:$HOME/.dotnet/tools/"

# Install postrgreSQL
apt install postgresql
sudo -u postgres psql template1

# Configure password
ALTER USER postgres with encrypted password 'p@ssw0rd';

\q

curl -o AspNetArm64VsX64LoadTesting.zip https://graviton-jigs1.s3.us-west-2.amazonaws.com/AspNetArm64VsX64LoadTesting.zip
apt install unzip -y
unzip AspNetArm64VsX64LoadTesting.zip -d AspNetArm64VsX64LoadTesting
cd AspNetArm64VsX64LoadTesting/AspNetArm64VsX64LoadTesting/src/aspnetcore/Benchmarks
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet run Benchmarks.csproj —scenarios=Plaintext,Json,StaticFiles,DbSingleQueryRaw,DbSingleQueryEf,DbSingleQueryDapper,DbMultiQueryRaw,DbMultiQueryEf,DbMultiQueryDapper,DbMultiUpdateRaw,DbMultiUpdateEf,DbMultiUpdateDapper,DbFortunesRaw,DbFortunesEf,DbFortunesDapper,MvcPlaintext,MvcJson,MvcViews,MvcDbSingleQueryRaw,MvcDbSingleQueryDapper,MvcDbSingleQueryEf,MvcDbMultiQueryRaw,MvcDbMultiQueryDapper,MvcDbMultiQueryEf,MvcDbMultiUpdateRaw,MvcDbMultiUpdateDapper,MvcDbMultiUpdateEf,MvcDbFortunesRaw,MvcDbFortunesEf,MvcDbFortunesDapper --urls=http://0.0.0.0:5000