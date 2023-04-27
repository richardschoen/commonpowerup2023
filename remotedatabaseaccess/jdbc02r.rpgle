      *  Demonstration of using the JDBCR4 service program to interact
      *  with a MySQL database and read records
      *
      *  To Compile:
      *     ** First, you need the JDBCR4 service program. See that
      *        source member for instructions. **
      *     CRTBNDRPG JDBC02R SRCFILE(xxx/xxx) DBGVIEW(*LIST)
      *
      *  To Run:
      *     CALL JDBC02C
      *
      *     Set credentials in JDBC02C program or add data areas.
      *
     H DFTACTGRP(*NO) BNDDIR('JDBC')

      /copy source,jdbc_h

     D JDBC02R         PR                  extpgm('JDBC02R')
     D    dburl                      50A   const
     D    dbname                     50A   const
     D    userid                     15A   const
     D    passwrd                    15A   const
     D JDBC02R         PI
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
     D rtn             s             10I 0
     D rs              s                   like(ResultSet)
     D itemNo          s              5P 0
     D Desc            s             25A
     D sql1            s           1024A


      /free
         *inlr = *on;

         // Connect to the MariaDB database via JDBC
         conn = MySql_Connect(%trim(dburl)
                             :%trim(dbname)
                             :%trim(userid)
                             :%trim(passwrd) );

         // Build SQL INSERT
         sql1='insert into QCUSTCDT +
         (CUSNUM,LSTNAM) VALUES(123457,''Schoen'')';

         // Query the records
         rtn=jdbc_ExecUpd(conn:%trim(sql1));

         // Display return code (Positive=recs affected, -1=Error)
         DSPLY %char(rtn);

         // Close the JDBC connection
         jdbc_close(conn);

         return;

      /end-free
