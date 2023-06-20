CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."SAT_TPCH_SUPPLIER_INIT"()
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



var truncate_SAT_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_DV_FL"."SAT_TPCH_SUPPLIER";
`} ).execute();


var SAT_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_DV_FL"."SAT_TPCH_SUPPLIER"(
		 "SUPPLIER_HKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"HASH_DIFF"
		,"DELETE_FLAG"
		,"CDC_TIMESTAMP"
		,"S_SUPPKEY"
		,"S_COMMENT"
		,"S_NAME"
		,"S_NATIONKEY"
		,"LOAD_TIMESTAMP"
		,"S_PHONE"
		,"S_ADDRESS"
		,"S_ACCTBAL"
	)
	WITH "STG_SRC" AS 
	( 
		SELECT 
			  "STG_INR_SRC"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
			, "STG_INR_SRC"."LOAD_DATE" AS "LOAD_DATE"
			, "STG_INR_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, UPPER(MD5_HEX(COALESCE(RTRIM( REPLACE(COALESCE(TRIM( "STG_INR_SRC"."S_NAME"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."S_ADDRESS")
				,'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_INR_SRC"."S_NATIONKEY")),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."S_PHONE"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_INR_SRC"."S_ACCTBAL")),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."S_COMMENT"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_INR_SRC"."LOAD_TIMESTAMP", 'DD/MM/YYYY HH24:MI:SS')),'~'),'\\#','\\\\' || '\\#')|| '\\#','\\#' || '~'),'~') )) AS "HASH_DIFF"
			, CAST('N' AS VARCHAR) AS "DELETE_FLAG"
			, "STG_INR_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
			, "STG_INR_SRC"."S_SUPPKEY" AS "S_SUPPKEY"
			, "STG_INR_SRC"."S_COMMENT" AS "S_COMMENT"
			, "STG_INR_SRC"."S_NAME" AS "S_NAME"
			, "STG_INR_SRC"."S_NATIONKEY" AS "S_NATIONKEY"
			, "STG_INR_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
			, "STG_INR_SRC"."S_PHONE" AS "S_PHONE"
			, "STG_INR_SRC"."S_ADDRESS" AS "S_ADDRESS"
			, "STG_INR_SRC"."S_ACCTBAL" AS "S_ACCTBAL"
			, ROW_NUMBER()OVER(PARTITION BY "STG_INR_SRC"."SUPPLIER_HKEY" ORDER BY "STG_INR_SRC"."LOAD_DATE") AS "DUMMY"
		FROM "TPCH_SF1_STG"."SUPPLIER" "STG_INR_SRC"
	)
	SELECT 
		  "STG_SRC"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
		, "STG_SRC"."LOAD_DATE" AS "LOAD_DATE"
		, "STG_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "STG_SRC"."HASH_DIFF" AS "HASH_DIFF"
		, "STG_SRC"."DELETE_FLAG" AS "DELETE_FLAG"
		, "STG_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "STG_SRC"."S_SUPPKEY" AS "S_SUPPKEY"
		, "STG_SRC"."S_COMMENT" AS "S_COMMENT"
		, "STG_SRC"."S_NAME" AS "S_NAME"
		, "STG_SRC"."S_NATIONKEY" AS "S_NATIONKEY"
		, "STG_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		, "STG_SRC"."S_PHONE" AS "S_PHONE"
		, "STG_SRC"."S_ADDRESS" AS "S_ADDRESS"
		, "STG_SRC"."S_ACCTBAL" AS "S_ACCTBAL"
	FROM "STG_SRC" "STG_SRC"
	WHERE  "STG_SRC"."DUMMY" = 1
	;
`} ).execute();

return "Done.";$$;
 
 
