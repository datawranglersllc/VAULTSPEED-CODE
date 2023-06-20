CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."SET_FMC_MTD_FL_INIT_TPCH"(P_DAG_NAME VARCHAR2,
P_LOAD_CYCLE_ID VARCHAR2,
P_LOAD_DATE VARCHAR2)
 RETURNS varchar 
LANGUAGE JAVASCRIPT 

AS $$ 
/*
 __     __          _ _                           _      __  ___  __   __   
 \ \   / /_ _ _   _| | |_ ___ ____   ___  ___  __| |     \ \/ _ \/ /  /_/   
  \ \ / / _` | | | | | __/ __|  _ \ / _ \/ _ \/ _` |      \/ / \ \/ /\      
   \ V / (_| | |_| | | |_\__ \ |_) |  __/  __/ (_| |      / / \/\ \/ /      
    \_/ \__,_|\__,_|_|\__|___/ .__/ \___|\___|\__,_|     /_/ \/_/\__/       
                             |_|                                            

Vaultspeed version: 5.3.1.1, generation date: 2023/06/17 03:45:02
DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 03:44:00, 
BV release: init(1) - Comment: initial release - Release date: 2023/06/17 01:44:13, 
SRC_NAME: TPCH_SF1 - Release: TPCH_SF1(1) - Comment: Release 1 of TPCH - Release date: 2023/06/17 03:37:07
 */



var HIST_INS = snowflake.createStatement( {sqlText: `
	INSERT INTO "SF_SAMPLE_FMC"."FMC_LOADING_HISTORY"(
		 "DAG_NAME"
		,"SRC_BK"
		,"LOAD_CYCLE_ID"
		,"LOAD_DATE"
		,"FMC_BEGIN_LW_TIMESTAMP"
		,"FMC_END_LW_TIMESTAMP"
		,"LOAD_START_DATE"
		,"LOAD_END_DATE"
		,"SUCCESS_FLAG"
	)
	SELECT 
		  '` + P_DAG_NAME + `' AS "DAG_NAME"
		, 'TPCH' AS "SRC_BK"
		, '` + P_LOAD_CYCLE_ID + `'::integer AS "LOAD_CYCLE_ID"
		, TO_TIMESTAMP('` + P_LOAD_DATE + `', 'YYYY-MM-DD HH24:MI:SS.FF6') AS "LOAD_DATE"
		, NULL AS "FMC_BEGIN_LW_TIMESTAMP"
		, TO_TIMESTAMP('` + P_LOAD_DATE + `', 'YYYY-MM-DD HH24:MI:SS.FF6') AS "FMC_END_LW_TIMESTAMP"
		, CURRENT_TIMESTAMP AS "LOAD_START_DATE"
		, NULL AS "LOAD_END_DATE"
		, NULL AS "SUCCESS_FLAG"
	WHERE  NOT EXISTS
	(
		SELECT 
			  1 AS "DUMMY"
		FROM "SF_SAMPLE_FMC"."FMC_LOADING_HISTORY" "FMCH_SRC"
		WHERE  "FMCH_SRC"."LOAD_CYCLE_ID" = '` + P_LOAD_CYCLE_ID + `'::integer
	)
	;
`} ).execute();

var truncate_LCI_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_SF1_MTD"."LOAD_CYCLE_INFO";
`} ).execute();


var LCI_INS = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_SF1_MTD"."LOAD_CYCLE_INFO"(
		 "LOAD_CYCLE_ID"
		,"LOAD_DATE"
	)
	SELECT 
		  '` + P_LOAD_CYCLE_ID + `'::integer AS "LOAD_CYCLE_ID"
		, TO_TIMESTAMP('` + P_LOAD_DATE + `', 'YYYY-MM-DD HH24:MI:SS.FF6') AS "LOAD_DATE"
	;
`} ).execute();

return "Done.";$$;
 
 
