# StatsCollector
Demo ASP.NET Core Project. It uses an ASP.NET Core API to read and write data to a datasource, in this case an MSSQL docker container

# Install Instructions
On a Windows machine running docker create the folder structure C:\Docker\sqlStatsCollector and copy the following files
  * dockerfile  
  * StatsCollector.sql  

Now Run the following commands to get MSSQL setup and running:  
  * docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Pwd12345!" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest  
  * docker build -t sqlstatscollector .  
  * docker run -p 11433:1433 -d sqlstatscollector  

Finally run the project using the StatsApi as the startup project

# Notes
  * No Security
  * Need to handle class mapping of input to output better. Input/ouput model naming? Automapper?
  * No localisation or timezones
  * Better way to handle the injection of config for connection strings?
  * Swagger Url: http://localhost:52620/swagger/index.html
  * Home Controller has no function but I've left it there as a template
