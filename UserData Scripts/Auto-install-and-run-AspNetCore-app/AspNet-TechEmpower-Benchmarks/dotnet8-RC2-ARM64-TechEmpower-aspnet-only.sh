#!/bin/bash
# Install .NET SDK 8.0.100-rc.2 for x64 then run TechEmpower ASP.NET Core benchmarks and PostgreSQL DB
sudo apt-get update -y
curl -o dotnet-sdk-8-arm64.tar.gz https://download.visualstudio.microsoft.com/download/pr/0247681a-1a4a-4a32-a1a6-4149d56af27e/5bcbf1d8189c2649b16d27f5199e04a4/dotnet-sdk-8.0.100-rc.2.23502.2-linux-arm64.tar.gz
mkdir /usr/bin/dotnet
sudo tar -xzvf dotnet-sdk-8-arm64.tar.gz -C /usr/bin/dotnet
sudo sh -c 'echo "alias dotnet=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export DOTNET_ROOT=/usr/bin/dotnet" >> /etc/environment'
sudo sh -c 'echo "export PATH=$PATH:$DOTNET_ROOT" >> /etc/environment'
set -a; source /etc/environment; set +a;

export PATH="$PATH:$HOME/.dotnet/tools/"
cat << \EOF >> ~/.bash_profile
# Add .NET Core SDK tools
export PATH="$PATH:/root/.dotnet/tools"
EOF

export PATH="$PATH:/home/ubuntu/.dotnet/tools"
cat << \EOF >> ~/.bash_profile
# Add .NET Core SDK tools
export PATH="$PATH:/home/ubuntu/.dotnet/tools"
EOF

# sudo /usr/bin/dotnet/dotnet tool install -g dotnet-ef --version 7.0.12
sudo /usr/bin/dotnet/dotnet tool install -g dotnet-ef --version 7.0.12


sudo /usr/bin/dotnet/dotnet workload update

# Install postrgreSQL
sudo apt install postgresql
sudo -u postgres psql template1

# Configure password
ALTER USER postgres with encrypted password 'p@ssw0rd';

\q

sudo apt install unzip -y
curl -o AspNetArm64VsX64LoadTesting.zip https://graviton-jigs1.s3.us-west-2.amazonaws.com/AspNetArm64VsX64LoadTesting.zip
sudo unzip AspNetArm64VsX64LoadTesting.zip -d AspNetArm64VsX64LoadTesting
cd AspNetArm64VsX64LoadTesting/AspNetArm64VsX64LoadTesting/src/aspnetcore/Benchmarks
sudo /usr/bin/dotnet/dotnet add package Microsoft.EntityFrameworkCore.Design
sudo /usr/bin/dotnet/dotnet run Benchmarks.csproj —scenarios=Plaintext,Json,StaticFiles,DbSingleQueryRaw,DbSingleQueryEf,DbSingleQueryDapper,DbMultiQueryRaw,DbMultiQueryEf,DbMultiQueryDapper,DbMultiUpdateRaw,DbMultiUpdateEf,DbMultiUpdateDapper,DbFortunesRaw,DbFortunesEf,DbFortunesDapper,MvcPlaintext,MvcJson,MvcViews,MvcDbSingleQueryRaw,MvcDbSingleQueryDapper,MvcDbSingleQueryEf,MvcDbMultiQueryRaw,MvcDbMultiQueryDapper,MvcDbMultiQueryEf,MvcDbMultiUpdateRaw,MvcDbMultiUpdateDapper,MvcDbMultiUpdateEf,MvcDbFortunesRaw,MvcDbFortunesEf,MvcDbFortunesDapper --urls=http://0.0.0.0:5000
