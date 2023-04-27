             /* Caller for Program JDBC02R                                */
             /* Needs the following data areas to exist in library list:  */
             /* DBURL - 50 Characters - Database host name or IP: Port    */
             /* DBNAME - 50 Characters - Database name.                   */
             /* DBUSER - 15 Characters - Store database name.             */
             /* DBPASS - 15 Characters - Store database name.             */
             PGM

             DCL        VAR(&URL)    TYPE(*CHAR) LEN(50)
             DCL        VAR(&DATABASE) TYPE(*CHAR) LEN(50)
             DCL        VAR(&USERID) TYPE(*CHAR) LEN(15)
             DCL        VAR(&PASSWRD) TYPE(*CHAR) LEN(15)
             DCL        VAR(&MSGID)  TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGF)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(100)
             DCL        VAR(&PGMNAM) TYPE(*CHAR) LEN(10) +
                          VALUE(JDBC02R)

 /* Error processing variables */
             DCL        VAR(&ERRBYTES)   TYPE(*CHAR) LEN(4) VALUE(X'00000000')
             DCL        VAR(&ERROR)      TYPE(*LGL)  VALUE('0')
             DCL        VAR(&MSGKEY)     TYPE(*CHAR) LEN(04)
             DCL        VAR(&MSGTYP)     TYPE(*CHAR) LEN(10) VALUE('*DIAG')
             DCL        VAR(&MSGTYPCTR)  TYPE(*CHAR) LEN(4) VALUE(X'00000001')
             DCL        VAR(&PGMMSGQ)    TYPE(*CHAR) LEN(10) VALUE('*')
             DCL        VAR(&STKCTR)     TYPE(*CHAR) LEN(4) VALUE(X'00000001')
             DCL        VAR(&JVM) TYPE(*CHAR) LEN(1024)
                        /* Java 1.4 64-Bit JVM */
             DCL        VAR(&JVM4064) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk14+
                          /64bit')
                        /* Java 1.5 32-Bit JVM */
             DCL        VAR(&JVM5032) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk50+
                          /32bit')
                        /* Java 1.6 32-Bit JVM */
             DCL        VAR(&JVM6032) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk60+
                          /32bit')
                        /* Java 1.7 32-Bit JVM */
             DCL        VAR(&JVM7032) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk70+
                          /32bit')
                        /* Java 1.8 32-Bit JVM */
             DCL        VAR(&JVM8032) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk80+
                          /32bit')
                        /* Java 1.5 64-Bit JVM */
             DCL        VAR(&JVM5064) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk50+
                          /64bit')
                        /* Java 1.6 64-Bit JVM */
             DCL        VAR(&JVM6064) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk60+
                          /64bit')
                        /* Java 1.7 64-Bit JVM */
             DCL        VAR(&JVM7064) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk70+
                          /64bit')
                        /* Java 1.8 64-Bit JVM */
             DCL        VAR(&JVM8064) TYPE(*CHAR) LEN(1024) +
                          VALUE('/QOpenSys/QIBM/ProdData/JavaVM/jdk80+
                          /64bit')

/*-----------------------------------------------------------*/
/* Default Monitoring */
/*-----------------------------------------------------------*/
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRPROC))

/*-----------------------------------------------------------*/
/* Mainline Routine                                          */
/*-----------------------------------------------------------*/

/*-----------------------------------------------------------*/
/* Set up java classpath where java class is located         */
/* also put hard references to any jar files if needed       */
/*-----------------------------------------------------------*/
             ADDENVVAR  ENVVAR(CLASSPATH) +
                          VALUE('/common2023/jdbc:/common2023/jdbc/mysql-co+
                          nnector-java-5.1.13-bin.jar') REPLACE(*YES)

/*-----------------------------------------------------------*/
/* Set JAVA_HOME classpath to set Java JVM runtime           */
/*-----------------------------------------------------------*/
             ADDENVVAR  ENVVAR(JAVA_HOME) VALUE(&JVM8032) +
                          CCSID(*JOB) LEVEL(*JOB) REPLACE(*YES)

/*-----------------------------------------------------------*/
/* Call the read QCUSTCDT sample                             */
/*-----------------------------------------------------------*/

             /* Set variables */
   /*        CHGVAR     VAR(&URL) VALUE('localhost:3306')   */
   /*        CHGVAR     VAR(&DATABASE) VALUE('database1')   */
   /*        CHGVAR     VAR(&USERID) VALUE('root')          */
   /*        CHGVAR     VAR(&PASSWRD) VALUE('password1')    */

             /* Set database info from data areas */
             RTVDTAARA  DTAARA(DBURL *ALL) RTNVAR(&URL)
             RTVDTAARA  DTAARA(DBNAME *ALL) RTNVAR(&DATABASE)
             RTVDTAARA  DTAARA(DBUSER *ALL) RTNVAR(&USERID)
             RTVDTAARA  DTAARA(DBPASS *ALL) RTNVAR(&PASSWRD)

             /* Call the program */
             CALL       PGM(&PGMNAM) PARM(&URL &DATABASE &USERID +
                          &PASSWRD)

 END:        RETURN

/*-----------------------------------------------------------*/
/* ERROR PROCESSING ROUTINE                                         */
/*-----------------------------------------------------------*/
 ERRPROC:    IF         COND(&ERROR) THEN(GOTO CMDLBL(ERRDONE))
             ELSE       CMD(CHGVAR VAR(&ERROR) VALUE('1'))

 /* MOVE ALL *DIAG MESSAGES TO THE PREVIOUS PROGRAM QUEUE */
             CALL       PGM(QMHMOVPM) PARM(&MSGKEY &MSGTYP &MSGTYPCTR &PGMMSGQ &STKCTR &ERRBYTES)

 /* RESEND LAST *ESCAPE MESSAGE */
 ERRDONE:    CALL       PGM(QMHRSNEM) PARM(&MSGKEY &ERRBYTES)
             MONMSG     MSGID(CPF0000) EXEC(DO)
                SNDPGMMSG  MSGID(CPF3CF2) MSGF(QCPFMSG) MSGDTA('QMHRSNEM') MSGTYPE(*ESCAPE)
                MONMSG     MSGID(CPF0000)
             ENDDO

             ENDPGM

