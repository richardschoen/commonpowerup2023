# Remote Database Access Samples

This directory will contain remote database access samples.

# IBM i System Prerequisites

## Create IFS directories
```
mkdir /common2023.  
mkdir /common2023/dbcli.  
mkdir /common2023/jdbc. 
```

## IBM i Libraries Needed
Make sure each of these libraries is installed a compiled on your IBM i system.    

They should also be in the library list. 

QShell on i - QSHEXEC  
https://github.com/richardschoen/qshoni

Scott Klement - JDBCR4    
https://scottklement.com/jdbc

Scott Klement - YAJL JSON.  
https://scottklement.com/yajl

## Open Source Package Manegement Packages needed 
Open source packages can be installed IBM Access Client Solutions - Open Source Package Management or via yum command line install commands.

### Python 3 packages
```
yum install python3   
yum install python39   
```

### MariaDB server
```
yum install mariadb.  
yum install mariadb-server    
```

### Install MySql Python Client
pip3 install PyMySql

# AppServer4RPG Samples for Remote Database Access

## ARDSAMP01R - Read QCUSTCDT table from MariaDB using embedded RPG SQL
The same uses the AppServer4RPG to connect to a remote MariaDB database and query the QCUSTCDT table.

# JDBCR4 Samples for Remote Database Access

## JDBC01C/JDBC01R - Use JDBC and Java from RPG to read data from MariaDB version of QCUSTCDT table.
This sample reads data from MariaDB table QCUSTCDT and displays it.    

The QCUSTCDT table must exist with data in it. Use QIWS/QCUSTCDT as a model for the MariaDB table.

## JDBC02C/JDBC02R - Use JDBC and Java from RPG to insert recoed to MariaDB version of QCUSTCDT table.
This sample writes a record via INSERT to MariaDB table QCUSTCDT.

The QCUSTCDT table must exist. Use QIWS/QCUSTCDT as a model for the MariaDB table.

# Python and RPG Command Line Database Access Samples




