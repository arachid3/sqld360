DEF section_name = 'Database Configuration';
SPO &&sqld360_main_report..html APP;
PRO <h2>&&section_name.</h2>
SPO OFF;

DEF title = 'Identification';
DEF main_table = 'V$DATABASE';
BEGIN
  :sql_text := '
SELECT d.dbid,
       d.name dbname,
       d.db_unique_name,
       d.platform_name,
       i.version,
       i.inst_id,
       i.instance_number,
       i.instance_name,
       LOWER(SUBSTR(i.host_name||''.'', 1, INSTR(i.host_name||''.'', ''.'') - 1)) host_name,
       p.value cpu_count,
       ''&&ebs_release.'' ebs_release,
       ''&&ebs_system_name.'' ebs_system_name,
       ''&&siebel_schema.'' siebel_schema,
       ''&&siebel_app_ver.'' siebel_app_ver,
       ''&&psft_schema.'' psft_schema,
       ''&&psft_tools_rel.'' psft_tools_rel
  FROM v$database d,
       gv$instance i,
       gv$system_parameter2 p
 WHERE p.inst_id = i.inst_id
   AND p.name = ''cpu_count''
';
END;				
/
@@sqld360_9a_pre_one.sql

DEF title = 'Version';
DEF main_table = 'V$VERSION';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       *
  FROM v$version
';
END;				
/
@@sqld360_9a_pre_one.sql

DEF title = 'Database';
DEF main_table = 'V$DATABASE';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       *
  FROM v$database
';
END;
/
@@sqld360_9a_pre_one.sql

DEF title = 'Instance';
DEF main_table = 'GV$INSTANCE';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       *
  FROM gv$instance
 ORDER BY
       inst_id
';
END;
/
@@sqld360_9a_pre_one.sql

--DEF title = 'Database and Instance History';
--DEF main_table = 'DBA_HIST_DATABASE_INSTANCE';
--BEGIN
--  :sql_text := '
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM dba_hist_database_instance
-- WHERE dbid = &&sqld360_dbid.
-- ORDER BY
--       dbid,
--       instance_number,
--       startup_time DESC
--';
--END;				
--/
--@@&&skip_diagnostics.sqld360_9a_pre_one.sql

--DEF title = 'Instance Recovery';
--DEF main_table = 'GV$INSTANCE_RECOVERY';
--BEGIN
--  :sql_text := '
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM gv$instance_recovery
-- ORDER BY
--       inst_id
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'Database Properties';
--DEF main_table = 'DATABASE_PROPERTIES';
--BEGIN
--  :sql_text := '
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM database_properties
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'Registry';
--DEF main_table = 'DBA_REGISTRY';
--BEGIN
--  :sql_text := '
-- incarnation from health_check_4.4 (Jon Adams and Jack Agustin)
--SELECT /*+ &&top_level_hints. */
--      *
--  FROM dba_registry
-- ORDER BY
--       comp_id
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'Registry History';
--DEF main_table = 'DBA_REGISTRY_HISTORY';
--BEGIN
--  :sql_text := '
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM dba_registry_history
-- ORDER BY
--       1
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'Registry Hierarchy';
--DEF main_table = 'DBA_REGISTRY_HIERARCHY';
--BEGIN
--  :sql_text := '
-- incarnation from health_check_4.4 (Jon Adams and Jack Agustin)
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM dba_registry_hierarchy
-- ORDER BY
--       1, 2, 3
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'Feature Usage Statistics';
--DEF main_table = 'DBA_FEATURE_USAGE_STATISTICS';
--BEGIN
--  :sql_text := '
-- incarnation from health_check_4.4 (Jon Adams and Jack Agustin)
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM dba_feature_usage_statistics
-- ORDER BY
--       name,
--       version
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'License';
--DEF main_table = 'GV$LICENSE';
--BEGIN
--  :sql_text := '
-- incarnation from health_check_4.4 (Jon Adams and Jack Agustin)
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM gv$license
-- ORDER BY
--       inst_id
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'Resource Limit';
--DEF main_table = 'GV$RESOURCE_LIMIT';
--BEGIN
--  :sql_text := '
-- incarnation from health_check_4.4 (Jon Adams and Jack Agustin)
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM gv$resource_limit
-- ORDER BY
--       resource_name,
--       inst_id
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

--DEF title = 'Database Links';
--DEF main_table = 'DBA_DB_LINKS';
--BEGIN
--  :sql_text := '
-- incarnation from health_check_4.4 (Jon Adams and Jack Agustin)
--SELECT /*+ &&top_level_hints. */
--       *
--  FROM dba_db_links
-- ORDER BY
--       owner,
--      db_link
--';
--END;
--/
--@@sqld360_9a_pre_one.sql

DEF title = 'Modified Parameters';
DEF main_table = 'GV$SYSTEM_PARAMETER2';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       *
  FROM gv$system_parameter2
 WHERE ismodified = ''MODIFIED''
 ORDER BY
       name,
       inst_id,
       ordinal
';
END;
/
@@sqld360_9a_pre_one.sql

DEF title = 'Non-default Parameters';
DEF main_table = 'GV$SYSTEM_PARAMETER2';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       *
  FROM gv$system_parameter2
 WHERE isdefault = ''FALSE''
 ORDER BY
       name,
       inst_id,
       ordinal
';
END;
/
@@sqld360_9a_pre_one.sql

DEF title = 'All Parameters';
DEF main_table = 'GV$SYSTEM_PARAMETER2';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       *
  FROM gv$system_parameter2
 ORDER BY
       name,
       inst_id,
       ordinal
';
END;
/
@@sqld360_9a_pre_one.sql

DEF title = 'Parameter File';
DEF main_table = 'V$SPPARAMETER';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       *
  FROM v$spparameter
 WHERE isspecified = ''TRUE''
 ORDER BY
       name,
       sid,
       ordinal
';
END;
/
@@_9a_pre_one.sql

DEF title = 'Alert Log';
DEF main_table = 'X$DBGALERTEXT';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */ 
       originating_timestamp,
       message_text
FROM sys.x$dbgalertext
WHERE originating_timestamp > SYSDATE - &&history_days.
ORDER BY originating_timestamp DESC
';
END;
/
@@&&skip_10g.sqld360_9a_pre_one.sql

DEF title = 'SQLTXPLAIN Version';
DEF main_table = 'SQLTXPLAIN.SQLI$_PARAMETER';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */ 
sqltxplain.sqlt$a.get_param(''tool_version'') sqlt_version,
sqltxplain.sqlt$a.get_param(''tool_date'') sqlt_version_date,
sqltxplain.sqlt$a.get_param(''install_date'') install_date
FROM DUAL
';
END;
/
@@sqld360_9a_pre_one.sql
