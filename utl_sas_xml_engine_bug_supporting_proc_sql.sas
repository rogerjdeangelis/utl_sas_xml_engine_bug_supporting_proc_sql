SAS XML engine bug supporting proc sql

see
https://communities.sas.com/t5/Base-SAS-Programming/Export-to-XML/m-p/426421

 This appears to be a bug because it works properly in WPS.
 Also works when using a datastep

INPUT  (simple xml file created using the SAS xml engine)
==========================================================

 d:/xml/utl_xml_sas_xml_engine_bug_supporting_proc_sql.xml

 <?xml version="1.0" encoding="windows-1252" ?>
 <TABLE>
    <CLASS>
       <NAME> Alfred </NAME>
       <SEX> M </SEX>
       <AGE> 14 </AGE>
       <HEIGHT> 69 </HEIGHT>
       <WEIGHT> 112.5 </WEIGHT>
    </CLASS>
    <CLASS>
       <NAME> Alice </NAME>
       <SEX> F </SEX>
       <AGE> 13 </AGE>
       <HEIGHT> 56.5 </HEIGHT>
       <WEIGHT> 84 </WEIGHT>
    </CLASS>
    <CLASS>
       <NAME> Barbara </NAME>
       <SEX> F </SEX>
       <AGE> 13 </AGE>
       <HEIGHT> 65.3 </HEIGHT>
       <WEIGHT> 98 </WEIGHT>
    </CLASS>
    ....

PROCESS

   libname dds xml "d:/xml/utl_xml_sas_xml_engine_bug_supporting_proc_sql.xml";
   proc sql;
    select name, height from dds.class
   ;quit;
   libname dds clear;


OUTPUT
======

 NAME       HEIGHT
 -----------------
      Ñÿ         0
      Ñÿ         0
      Ñÿ         0
      Ñÿ         0

 ....

 *               _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;


%utlfkil(d:/xml/utl_xml_sas_xml_engine_bug_supporting_proc_sql.xml);
libname dds xml "d:/xml/utl_xml_sas_xml_engine_bug_supporting_proc_sql.xml";

data dds.class;
set sashelp.class;
run;

libname dds clear;

*                _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| '_ \| '__/ _ \| '_ \| |/ _ \ '_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
;


libname dds xml "d:/xml/utl_xml_sas_xml_engine_bug_supporting_proc_sql.xml";
proc sql;
 select name, height from dds.class
;quit;
libname dds clear;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;


%utl_submit_wps64('
libname wrk sas7bdat "%sysfunc(pathname(work))";
libname dds xml "d:/xml/utl_xml_sas_xml_engine_bug_supporting_proc_sql.xml";
proc sql;
 select name, height from dds.class
;quit;
libname dds clear;
run;quit;
');


The WPS System

NAME     HEIGHT
---------------
Alfred       69
Alice        57
Barbara      65
Carol        63
Henry        64
James        57
Jane         60


