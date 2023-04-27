       ctl-opt dftactgrp(*no);
      //--------------------------------------------------------------------
      // Desc: Query MariaDB QCUSTCDT and Process All Rows
      // https://www.mcpressonline.com/programming/rpg/qualified-data-structures
      // AppServer4RPG Sample that uses MariaDB connection named DBMYSQL.
      // Note:
      // Make sure QIWS is in your library list when compiling this program.
      //--------------------------------------------------------------------

      // Declare external data structure
      // Can use qualified DS if you want it to be qualified like we did
        DCL-DS dsCust  EXTNAME('QCUSTCDT') QUALIFIED INZ END-DS;

      // Execute CL commands
        dcl-pr qcmdexc ExtPgm;
          cmd          char(4096)     Const Options(*VarSize);
          cmdLength    packed(15: 5) Const;
        END-PR;

       Dcl-Ds *N psds;
         PROGID *PROC;
       End-Ds;

        dcl-pr RunCommand int(10);
            parmcmd       char(4096)     Const Options(*VarSize);
        end-pr;

     Dcount            S              5P 0
     Dsqlquery1        S           2048          Varying
     Dcmd              S          32702          Varying
     Drc               S             10i 0
     Drmtsys           S             30A         Varying
     Drmtuser          S             15A         Varying
     Drmtpass          S             15A         Varying

      // System Header Includes
      /include qsysinc/qrpglesrc,qcdrcmdd
      /include qsysinc/qrpglesrc,qcdrcmdi
      /include qsysinc/qrpglesrc,qusec

      /free

       // Base SQL statement
       // Program assumes "WHERE" parameter will contain
       // the word WHERE
       sqlquery1='Select * from QCUSTCDT';

       // Set up SQL call and open cursor
       // For AppServer4RPG, set name=*SQL or get SQL error.
         exec SQL
           Set Option naming=*SQL;

       // Connect to MariaDB for SQL
       rmtsys='DBMYSQL';
       rmtuser='user1';
       rmtpass='pass1';
       Exec SQL
          connect to :rmtsys user :rmtuser using :rmtpass;

       // Prepare SQL statement
       Exec SQL
         Prepare stmt1 From :sqlquery1;

       // Declare a cursor for the statment
       Exec SQL
         Declare cursor1 Cursor For stmt1;

       // Run the query and open cursor
       Exec SQL
         Open cursor1;

       // If errors on the query, exit
       if sqlcode <> 0;
         *inlr=*on;
         return;
       endif;

       // Loop through data and build HTML list
       Dow sqlcode = 0;

         // Fetch next record in data set
         Exec SQL FETCH cursor1 into :dsCust;

         // If errors occur, loop back to start of loop
         if sqlcode <> 0;
           leave;
         endif;

         // TODO - Process record contents now
         dsply dsCust.Cusnum;
         count += 1;


       enddo;

       // Close DB cursor
       Exec SQL
       Close cursor1;

       // Exit program
       *inlr=*on;
       return;

       //----------------------------------------------------------------
       // Procedure: RunCommand
       // Desc: RunCommand subprocedure. Run CL command
       //----------------------------------------------------------------
       dcl-proc RunCommand export;
         dcl-pi   *N       int(10);
           parmcmd       char(4096)     Const Options(*VarSize);
         end-pi;

         // Run command and handle any errors nicely.
         // We just want to return success or fail.
         monitor;
            qcmdexc(%trim(parmcmd):%len(%trim(parmcmd)));
            return 0;
         on-error;
           return -1;
         endmon;

       end-proc RunCommand;

