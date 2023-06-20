CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."STG_TPCH_SUPPLIER_INIT"()
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



var truncate_STG_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_SF1_STG"."SUPPLIER";
`} ).execute();


var STG_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_SF1_STG"."SUPPLIER"(
		 "SUPPLIER_HKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"SRC_BK"
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
	SELECT 
		  UPPER(MD5_HEX( 'TPCH' || '\\#' || "EXT_SRC"."S_SUPPKEY_BK" || '\\#' )) AS "SUPPLIER_HKEY"
		, "EXT_SRC"."LOAD_DATE" AS "LOAD_DATE"
		, "EXT_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, 'TPCH' AS "SRC_BK"
		, "EXT_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "EXT_SRC"."JRN_FLAG" AS "JRN_FLAG"
		, "EXT_SRC"."RECORD_TYPE" AS "RECORD_TYPE"
		, "EXT_SRC"."S_SUPPKEY" AS "S_SUPPKEY"
		, "EXT_SRC"."S_SUPPKEY_BK" AS "S_SUPPKEY_BK"
		, "EXT_SRC"."S_NAME" AS "S_NAME"
		, "EXT_SRC"."S_ADDRESS" AS "S_ADDRESS"
		, "EXT_SRC"."S_NATIONKEY" AS "S_NATIONKEY"
		, "EXT_SRC"."S_PHONE" AS "S_PHONE"
		, "EXT_SRC"."S_ACCTBAL" AS "S_ACCTBAL"
		, "EXT_SRC"."S_COMMENT" AS "S_COMMENT"
		, "EXT_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
	FROM "TPCH_SF1_EXT"."SUPPLIER" "EXT_SRC"
	INNER JOIN "TPCH_SF1_MTD"."MTD_EXCEPTION_RECORDS" "MEX_SRC" ON  "MEX_SRC"."RECORD_TYPE" = 'U'
	;
`} ).execute();

return "Done.";$$;
 
 
