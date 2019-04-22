#!/bin/bash

read -p "Enter Database Name: "  dbname
echo -n Password: 
read -s passWord
sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD='$passWord -p 1433:1433 --name sql1 -d mcr.microsoft.com/mssql/server:2017-latest
sleep 40
docker exec -it sql1 mkdir /var/opt/mssql/backup
docker cp $dbname.bak sql1:/var/opt/mssql/backup
docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $passWord -Q 'RESTORE DATABASE '$dbname' FROM DISK = "/var/opt/mssql/backup/'$dbname'.bak" WITH MOVE "'$dbname'" TO "/var/opt/mssql/data/'$dbname'.mdf", MOVE "'$dbname'_Log" TO "/var/opt/mssql/data/'$dbname'.ldf"'
