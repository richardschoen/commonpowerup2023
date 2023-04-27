      *  Demonstration of using the JDBCR4 service program to interact
      *  with a MySQL database and read records
      *
      *  To Compile:
      *     ** First, you need the JDBCR4 service program. See that
      *        source member for instructions. **
      *     CRTBNDRPG JDBC01R SRCFILE(xxx/xxx) DBGVIEW(*LIST)
      *
      *  To Run:
      *     CALL JDBC01C
      *
      *     Set credentials in JDBC01C program or add data areas.
      *
     H DFTACTGRP(*NO) BNDDIR('JDBC')

     FQSYSPRT   O    F  132        PRINTER

      /copy source,jdbc_h

     D JDBC01R         PR                  extpgm('JDBC01R')
     D    dburl                      50A   const
     D    dbname                     50A   const
     D    userid                     15A   const
     D    passwrd                    15A   const
     D JDBC01R         PI
     D    dburl                      50A   const
     D    dbname                     50A   const
     D    userid                     15A   const
     D    passwrd                    15A   const

     D CusNum          s              6S 0
     D LstNam          s              8A
     D Init            s              3A
     D Street          s             13A
     D City            s              6A
     D State           s              2A
     D ZipCod          s              5S 0
     D CdtLmt          s              4S 0
     D ChgCod          s              1S 0
     D BalDue          s              6S 2
     D CdtDue          s              6S 2

     D conn            s                   like(Connection)
     D ErrMsg          s             50A
     D wait            s              1A
     D count           s             10I 0
     D rs              s                   like(ResultSet)
     D itemNo          s              5P 0
     D Desc            s             25A


      /free
         *inlr = *on;

         // Connect to the MariaDB database via JDBC
         conn = MySql_Connect(%trim(dburl)
                             :%trim(dbname)
                             :%trim(userid)
                             :%trim(passwrd) );
         // Query the records
         rs = jdbc_ExecQry(conn:'Select * from QCUSTCDT');

         // Write report column headings
         except Header;
         except Header2;

         // Iterate the query resultset
         dow (jdbc_nextRow(rs));

           // Extract fields from record
           CusNum = %int(jdbc_getCol(rs:1));
           LstNam = jdbc_getCol(rs:2);
           Init = jdbc_getCol(rs:3);
           Street = jdbc_getCol(rs:4);
           City = jdbc_getCol(rs:5);
           State = jdbc_getCol(rs:6);
           ZipCod = %dec(jdbc_getCol(rs:7):5:0);
           CdtLmt = %dec(jdbc_getCol(rs:8):4:0);
           ChgCod = %int(jdbc_getCol(rs:9));
           BalDue = %dec(jdbc_getCol(rs:10):6:2);
           CdtDue = %dec(jdbc_getCol(rs:11):6:2);

           // Write record to report
           except Report1;

         enddo;

         // Release the resultset memory
         jdbc_freeResult(rs);

         // Close the JDBC connection
         jdbc_close(conn);

         return;

      /end-free

     OQSYSPRT   E            Report1
     O                       Cusnum               6
     O                       LstNam              15
     O                       Init                19
     O                       Street              34
     O                       City                41
     O                       State               44
     O                       ZipCod              50
     O                       CdtLmt        1     56
     O                       ChgCod              60
     O                       BalDue        1     71
     O                       CdtDue        1     81
     O          E            Header
     O                                           13 'Customer List'
     O          E            Header2
     O                                            6 'Cust  '
     O                                           13 'Last  '
     O                                           20 'Init'
     O                                           27 'Street'
     O                                           39 'City'
     O                                           44 'St'
     O                                           48 'Zip'
     O                                           56 'Limit'
     O                                           61 'Chg'
     O                                           71 'BalDue'
     O                                           81 'CdtDue'
