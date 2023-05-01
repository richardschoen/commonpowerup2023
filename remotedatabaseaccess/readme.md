# Remote Database Access Samples

This directory will contain remote database access samples.

# IBM i System Prerequisites

## IBM i Libraries Needed

QShell on i - QSHEXEC  
https://github.com/richardschoen/qshoni

Scott Klement - JDBCR4    
https://scottklement.com/jdbc

Scott Klement - YAJL JSON.  
https://scottklement.com/yajl

## Open Source Package Manegement Packages needed (yum installs)

### Python 3 packages
python3   
python39   

### MariaDB server
mariadb.  
mariadb-server    

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




