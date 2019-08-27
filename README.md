# StatsCollector
Demo ASP.NET Core Project. It uses an ASP.NET Core API to read and write data to a datasource, in this case an MSSQL docker container

# Docker Instructions
On a Windows machine running docker create the folder structure C:\Docker\sqlStatsCollector and copy the following files
  * dockerfile  
  * StatsCollector.sql  

Now Run the following commands to get MSSQL setup and running:  
  * docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Pwd12345!" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest  
  * docker build -t sqlstatscollector .  
  * docker run -p 11433:1433 -d sqlstatscollector  

# Notes
  * No Security
  * Need to handle mapping of input to output better. input/ouput model naming? Automapper?
  * No localisation or timezones
  * Better way to handle the injection of config for connection strings?
  * Swagger UrL: http://localhost:52620/swagger/index.html]
