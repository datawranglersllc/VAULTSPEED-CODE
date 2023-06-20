CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."LDS_TPCH_PARTSUPP_INIT"()
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



var truncate_LDS_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_DV_FL"."LDS_TPCH_PARTSUPP";
`} ).execute();


var LDS_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_DV_FL"."LDS_TPCH_PARTSUPP"(
		 "LND_PARTSUPP_HKEY"
		,"PS_PARTKEY"
		,"PS_SUPPKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"HASH_DIFF"
		,"DELETE_FLAG"
		,"CDC_TIMESTAMP"
		,"PS_COMMENT"
		,"PS_SUPPLYCOST"
		,"LOAD_TIMESTAMP"
		,"PS_AVAILQTY"
	)
	WITH "STG_DL_SRC" AS 
	( 
		SELECT 
			  "STG_DL_INR_SRC"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
			, "STG_DL_INR_SRC"."PS_PARTKEY" AS "PS_PARTKEY"
			, "STG_DL_INR_SRC"."PS_SUPPKEY" AS "PS_SUPPKEY"
			, "STG_DL_INR_SRC"."LOAD_DATE" AS "LOAD_DATE"
			, "STG_DL_INR_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, UPPER(MD5_HEX(COALESCE(RTRIM( REPLACE(COALESCE(TRIM( TO_CHAR("STG_DL_INR_SRC"."PS_AVAILQTY")),'~'),'\\#','\\\\' || 
				'\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_DL_INR_SRC"."PS_SUPPLYCOST")),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_DL_INR_SRC"."PS_COMMENT"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_DL_INR_SRC"."LOAD_TIMESTAMP", 'DD/MM/YYYY HH24:MI:SS')),'~'),'\\#','\\\\' || '\\#')|| '\\#','\\#' || '~'),'~') )) AS "HASH_DIFF"
			, CAST('N' AS VARCHAR) AS "DELETE_FLAG"
			, "STG_DL_INR_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
			, "STG_DL_INR_SRC"."PS_COMMENT" AS "PS_COMMENT"
			, "STG_DL_INR_SRC"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
			, "STG_DL_INR_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
			, "STG_DL_INR_SRC"."PS_AVAILQTY" AS "PS_AVAILQTY"
			, ROW_NUMBER()OVER(PARTITION BY "STG_DL_INR_SRC"."LND_PARTSUPP_HKEY" ORDER BY "STG_DL_INR_SRC"."LOAD_DATE") AS "DUMMY"
		FROM "TPCH_SF1_STG"."PARTSUPP" "STG_DL_INR_SRC"
	)
	SELECT 
		  "STG_DL_SRC"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
		, "STG_DL_SRC"."PS_PARTKEY" AS "PS_PARTKEY"
		, "STG_DL_SRC"."PS_SUPPKEY" AS "PS_SUPPKEY"
		, "STG_DL_SRC"."LOAD_DATE" AS "LOAD_DATE"
		, "STG_DL_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "STG_DL_SRC"."HASH_DIFF" AS "HASH_DIFF"
		, "STG_DL_SRC"."DELETE_FLAG" AS "DELETE_FLAG"
		, "STG_DL_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "STG_DL_SRC"."PS_COMMENT" AS "PS_COMMENT"
		, "STG_DL_SRC"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
		, "STG_DL_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		, "STG_DL_SRC"."PS_AVAILQTY" AS "PS_AVAILQTY"
	FROM "STG_DL_SRC" "STG_DL_SRC"
	WHERE  "STG_DL_SRC"."DUMMY" = 1
	;
`} ).execute();

return "Done.";$$;
 
 
