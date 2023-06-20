CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."SAT_TPCH_PART_INIT"()
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
	TRUNCATE TABLE "TPCH_DV_FL"."SAT_TPCH_PART";
`} ).execute();


var SAT_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_DV_FL"."SAT_TPCH_PART"(
		 "PART_HKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"HASH_DIFF"
		,"DELETE_FLAG"
		,"CDC_TIMESTAMP"
		,"P_PARTKEY"
		,"P_CONTAINER"
		,"P_MFGR"
		,"P_TYPE"
		,"P_SIZE"
		,"P_RETAILPRICE"
		,"P_COMMENT"
		,"P_NAME"
		,"LOAD_TIMESTAMP"
		,"P_BRAND"
	)
	WITH "STG_SRC" AS 
	( 
		SELECT 
			  "STG_INR_SRC"."PART_HKEY" AS "PART_HKEY"
			, "STG_INR_SRC"."LOAD_DATE" AS "LOAD_DATE"
			, "STG_INR_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, UPPER(MD5_HEX(COALESCE(RTRIM( REPLACE(COALESCE(TRIM( "STG_INR_SRC"."P_NAME"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."P_MFGR")
				,'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."P_BRAND"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."P_TYPE"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_INR_SRC"."P_SIZE")),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."P_CONTAINER"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_INR_SRC"."P_RETAILPRICE")),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_INR_SRC"."P_COMMENT"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_INR_SRC"."LOAD_TIMESTAMP", 'DD/MM/YYYY HH24:MI:SS')),'~'),'\\#','\\\\' || '\\#')|| '\\#','\\#' || '~'),'~') )) AS "HASH_DIFF"
			, CAST('N' AS VARCHAR) AS "DELETE_FLAG"
			, "STG_INR_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
			, "STG_INR_SRC"."P_PARTKEY" AS "P_PARTKEY"
			, "STG_INR_SRC"."P_CONTAINER" AS "P_CONTAINER"
			, "STG_INR_SRC"."P_MFGR" AS "P_MFGR"
			, "STG_INR_SRC"."P_TYPE" AS "P_TYPE"
			, "STG_INR_SRC"."P_SIZE" AS "P_SIZE"
			, "STG_INR_SRC"."P_RETAILPRICE" AS "P_RETAILPRICE"
			, "STG_INR_SRC"."P_COMMENT" AS "P_COMMENT"
			, "STG_INR_SRC"."P_NAME" AS "P_NAME"
			, "STG_INR_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
			, "STG_INR_SRC"."P_BRAND" AS "P_BRAND"
			, ROW_NUMBER()OVER(PARTITION BY "STG_INR_SRC"."PART_HKEY" ORDER BY "STG_INR_SRC"."LOAD_DATE") AS "DUMMY"
		FROM "TPCH_SF1_STG"."PART" "STG_INR_SRC"
	)
	SELECT 
		  "STG_SRC"."PART_HKEY" AS "PART_HKEY"
		, "STG_SRC"."LOAD_DATE" AS "LOAD_DATE"
		, "STG_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "STG_SRC"."HASH_DIFF" AS "HASH_DIFF"
		, "STG_SRC"."DELETE_FLAG" AS "DELETE_FLAG"
		, "STG_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "STG_SRC"."P_PARTKEY" AS "P_PARTKEY"
		, "STG_SRC"."P_CONTAINER" AS "P_CONTAINER"
		, "STG_SRC"."P_MFGR" AS "P_MFGR"
		, "STG_SRC"."P_TYPE" AS "P_TYPE"
		, "STG_SRC"."P_SIZE" AS "P_SIZE"
		, "STG_SRC"."P_RETAILPRICE" AS "P_RETAILPRICE"
		, "STG_SRC"."P_COMMENT" AS "P_COMMENT"
		, "STG_SRC"."P_NAME" AS "P_NAME"
		, "STG_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		, "STG_SRC"."P_BRAND" AS "P_BRAND"
	FROM "STG_SRC" "STG_SRC"
	WHERE  "STG_SRC"."DUMMY" = 1
	;
`} ).execute();

return "Done.";$$;
 
 
