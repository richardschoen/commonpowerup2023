#!/QOpenSys/pkgs/bin/python3
#------------------------------------------------
# Script name: mariadbconn1.py
#
# Description: 
# This script will run a test MariaDB connection and data list.
#
# Pip packages needed:
# pip install --upgrade PyMySql (Database driver)
#
# Links:
# https://docs.python.org/3/library/configparser.html
# https://pypi.org/project/pymysql
#------------------------------------------------
import configparser #Import config file parser
import sys
from dbmariadb import DbMariaDb # Import our database class

#------------------------------------------------
# Main script
#------------------------------------------------

# Read connection settings from config.py file
config = configparser.ConfigParser()
config.read('config.py')
host=config['mariadb']['host']
user=config['mariadb']['user']
password=config['mariadb']['password']
port=int(config['mariadb']['port'])
database=config['mariadb']['database']

# Instantiate db class and open database
db=DbMariaDb(host,user,password,database,port)

# Bail out if no connection
if (db.isopen()==False):
   print("No connection to database. Exiting now.")
   sys.exit()

# Query QCUSTCDT table from database
c1=db.execute_query("select * from QCUSTCDT")

# Fetch all results
rows = c1.fetchall()

# Get field metadata names from cursor
column_names = [desc[0] for desc in c1.description]
rowheader=""
tempdelim=""

# Iterate and output column names
##for colname in column_names:
    # Append value to consolidated row header record
    ##rowheader = rowheader + str(colname) + "|"
    ## Output row header only for new file. Skip last char 
    ## to remove trailing delimiter on the last field
##print(rowheader[0:len(rowheader)-1] + "\r\n")
   
# Iterate and output data rows 
reccount=0
for row in rows:
    rowdata=""
    curcol=0
    # Iterate all columns in each row
    for col in row:
        # Append value to consolidated row data record
        rowdata = rowdata + str(row[col]) + "|"
        # Increment current column number
        curcol=curcol+1

    # Output data row and increment record count Skip last char 
    # to remove trailing delimiter on the last field
    print(rowdata[0:len(rowdata)-1] + "\r\n")
    reccount += 1
