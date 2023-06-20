CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."EXT_TPCH_SUPPLIER_INCR"()
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
	TRUNCATE TABLE "TPCH_SF1_EXT"."SUPPLIER";
`} ).execute();


var EXT_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_SF1_EXT"."SUPPLIER"(
		 "LOAD_CYCLE_ID"
		,"LOAD_DATE"
		,"CDC_TIMESTAMP"
		,"JRN_FLAG"
		,"RECORD_TYPE"
		,"S_SUPPKEY"
		,"S_SUPPKEY_BK"
		,"S_NAME"
		,"S_ADDRESS"
		,"S_NATIONKEY"
		,"S_PHONE"
		,"S_ACCTBAL"
		,"S_COMMENT"
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
			, "TDFV_SRC"."S_SUPPKEY" AS "S_SUPPKEY"
			, COALESCE(UPPER( TO_CHAR("TDFV_SRC"."S_SUPPKEY")),"MEX_SRC"."KEY_ATTRIBUTE_INTEGER") AS "S_SUPPKEY_BK"
			, "TDFV_SRC"."S_NAME" AS "S_NAME"
			, "TDFV_SRC"."S_ADDRESS" AS "S_ADDRESS"
			, "TDFV_SRC"."S_NATIONKEY" AS "S_NATIONKEY"
			, "TDFV_SRC"."S_PHONE" AS "S_PHONE"
			, "TDFV_SRC"."S_ACCTBAL" AS "S_ACCTBAL"
			, "TDFV_SRC"."S_COMMENT" AS "S_COMMENT"
			, "TDFV_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		FROM "TPCH_SF1_DFV"."VW_SUPPLIER" "TDFV_SRC"
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
			, "CALCULATE_BK"."S_SUPPKEY" AS "S_SUPPKEY"
			, "CALCULATE_BK"."S_SUPPKEY_BK" AS "S_SUPPKEY_BK"
			, "CALCULATE_BK"."S_NAME" AS "S_NAME"
			, "CALCULATE_BK"."S_ADDRESS" AS "S_ADDRESS"
			, "CALCULATE_BK"."S_NATIONKEY" AS "S_NATIONKEY"
			, "CALCULATE_BK"."S_PHONE" AS "S_PHONE"
			, "CALCULATE_BK"."S_ACCTBAL" AS "S_ACCTBAL"
			, "CALCULATE_BK"."S_COMMENT" AS "S_COMMENT"
			, "CALCULATE_BK"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		FROM "CALCULATE_BK" "CALCULATE_BK"
	)
	SELECT 
		  "EXT_UNION"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "EXT_UNION"."LOAD_DATE" AS "LOAD_DATE"
		, "EXT_UNION"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "EXT_UNION"."JRN_FLAG" AS "JRN_FLAG"
		, "EXT_UNION"."RECORD_TYPE" AS "RECORD_TYPE"
		, "EXT_UNION"."S_SUPPKEY" AS "S_SUPPKEY"
		, "EXT_UNION"."S_SUPPKEY_BK" AS "S_SUPPKEY_BK"
		, "EXT_UNION"."S_NAME" AS "S_NAME"
		, "EXT_UNION"."S_ADDRESS" AS "S_ADDRESS"
		, "EXT_UNION"."S_NATIONKEY" AS "S_NATIONKEY"
		, "EXT_UNION"."S_PHONE" AS "S_PHONE"
		, "EXT_UNION"."S_ACCTBAL" AS "S_ACCTBAL"
		, "EXT_UNION"."S_COMMENT" AS "S_COMMENT"
		, "EXT_UNION"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
	FROM "EXT_UNION" "EXT_UNION"
	;
`} ).execute();

return "Done.";$$;
 
 
