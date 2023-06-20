CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."EXT_TPCH_PART_INCR"()
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



var truncate_EXT_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_SF1_EXT"."PART";
`} ).execute();


var EXT_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_SF1_EXT"."PART"(
		 "LOAD_CYCLE_ID"
		,"LOAD_DATE"
		,"CDC_TIMESTAMP"
		,"JRN_FLAG"
		,"RECORD_TYPE"
		,"P_PARTKEY"
		,"P_PARTKEY_BK"
		,"P_NAME"
		,"P_MFGR"
		,"P_BRAND"
		,"P_TYPE"
		,"P_SIZE"
		,"P_CONTAINER"
		,"P_RETAILPRICE"
		,"P_COMMENT"
		,"LOAD_TIMESTAMP"
	)
	WITH "CALCULATE_BK" AS 
	( 
		SELECT 
			  "LCI_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, DATEADD(microsecond, 2*row_number() over (order by "TDFV_SRC"."CDC_TIMESTAMP"),
				TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP()))   AS "LOAD_DATE"
			, "TDFV_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
			, "MEX_SRC"."ATTRIBUTE_VARCHAR" AS "JRN_FLAG"
			, "TDFV_SRC"."RECORD_TYPE" AS "RECORD_TYPE"
			, "TDFV_SRC"."P_PARTKEY" AS "P_PARTKEY"
			, COALESCE(UPPER( TO_CHAR("TDFV_SRC"."P_PARTKEY")),"MEX_SRC"."KEY_ATTRIBUTE_INTEGER") AS "P_PARTKEY_BK"
			, "TDFV_SRC"."P_NAME" AS "P_NAME"
			, "TDFV_SRC"."P_MFGR" AS "P_MFGR"
			, "TDFV_SRC"."P_BRAND" AS "P_BRAND"
			, "TDFV_SRC"."P_TYPE" AS "P_TYPE"
			, "TDFV_SRC"."P_SIZE" AS "P_SIZE"
			, "TDFV_SRC"."P_CONTAINER" AS "P_CONTAINER"
			, "TDFV_SRC"."P_RETAILPRICE" AS "P_RETAILPRICE"
			, "TDFV_SRC"."P_COMMENT" AS "P_COMMENT"
			, "TDFV_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		FROM "TPCH_SF1_DFV"."VW_PART" "TDFV_SRC"
		INNER JOIN "TPCH_SF1_MTD"."LOAD_CYCLE_INFO" "LCI_SRC" ON  1 = 1
		INNER JOIN "TPCH_SF1_MTD"."MTD_EXCEPTION_RECORDS" "MEX_SRC" ON  1 = 1
		WHERE  "MEX_SRC"."RECORD_TYPE" = 'N'
	)
	, "EXT_UNION" AS 
	( 
		SELECT 
			  "CALCULATE_BK"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, "CALCULATE_BK"."LOAD_DATE" AS "LOAD_DATE"
			, "CALCULATE_BK"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
			, "CALCULATE_BK"."JRN_FLAG" AS "JRN_FLAG"
			, "CALCULATE_BK"."RECORD_TYPE" AS "RECORD_TYPE"
			, "CALCULATE_BK"."P_PARTKEY" AS "P_PARTKEY"
			, "CALCULATE_BK"."P_PARTKEY_BK" AS "P_PARTKEY_BK"
			, "CALCULATE_BK"."P_NAME" AS "P_NAME"
			, "CALCULATE_BK"."P_MFGR" AS "P_MFGR"
			, "CALCULATE_BK"."P_BRAND" AS "P_BRAND"
			, "CALCULATE_BK"."P_TYPE" AS "P_TYPE"
			, "CALCULATE_BK"."P_SIZE" AS "P_SIZE"
			, "CALCULATE_BK"."P_CONTAINER" AS "P_CONTAINER"
			, "CALCULATE_BK"."P_RETAILPRICE" AS "P_RETAILPRICE"
			, "CALCULATE_BK"."P_COMMENT" AS "P_COMMENT"
			, "CALCULATE_BK"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		FROM "CALCULATE_BK" "CALCULATE_BK"
	)
	SELECT 
		  "EXT_UNION"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "EXT_UNION"."LOAD_DATE" AS "LOAD_DATE"
		, "EXT_UNION"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "EXT_UNION"."JRN_FLAG" AS "JRN_FLAG"
		, "EXT_UNION"."RECORD_TYPE" AS "RECORD_TYPE"
		, "EXT_UNION"."P_PARTKEY" AS "P_PARTKEY"
		, "EXT_UNION"."P_PARTKEY_BK" AS "P_PARTKEY_BK"
		, "EXT_UNION"."P_NAME" AS "P_NAME"
		, "EXT_UNION"."P_MFGR" AS "P_MFGR"
		, "EXT_UNION"."P_BRAND" AS "P_BRAND"
		, "EXT_UNION"."P_TYPE" AS "P_TYPE"
		, "EXT_UNION"."P_SIZE" AS "P_SIZE"
		, "EXT_UNION"."P_CONTAINER" AS "P_CONTAINER"
		, "EXT_UNION"."P_RETAILPRICE" AS "P_RETAILPRICE"
		, "EXT_UNION"."P_COMMENT" AS "P_COMMENT"
		, "EXT_UNION"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
	FROM "EXT_UNION" "EXT_UNION"
	;
`} ).execute();

return "Done.";$$;
 
 
