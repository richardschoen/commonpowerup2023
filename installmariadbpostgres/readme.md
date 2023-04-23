# Test PostgreSQL and MariaDB Connectivity

Download and install these scripts to an existing IFS work directory such as ```/common2023```
  
Edit and add your PostgreSQL and MariaDB credentials to the ```config.py``` file.   

At a bash command line,  key: ```python3 mariadbconn1.py```and press enter to test MariaDB connection and list records from QCUSTCDT table.    
 
If records are listed the process was successful.  Otherwise review any Python warning or error messages to troubleshoot.

At a bash command line,  key: ```python3 postgresconn1.py```and press enter to test PostgreSQL connection and list records from QCUSTCDT table.   

If records are listed the process was successful.  Otherwise review any Python warning or error messages to troubleshoot.
