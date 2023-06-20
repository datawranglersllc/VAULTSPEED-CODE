CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."LDS_TPCH_PARTSUPP_INCR"()
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



var truncate_LDS_TEMP_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_SF1_STG"."LDS_TPCH_PARTSUPP_TMP";
`} ).execute();


var LDS_TEMP_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_SF1_STG"."LDS_TPCH_PARTSUPP_TMP"(
		 "LND_PARTSUPP_HKEY"
		,"PART_HKEY"
		,"SUPPLIER_HKEY"
		,"PS_PARTKEY"
		,"PS_SUPPKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"HASH_DIFF"
		,"RECORD_TYPE"
		,"SOURCE"
		,"EQUAL"
		,"DELETE_FLAG"
		,"CDC_TIMESTAMP"
		,"PS_COMMENT"
		,"PS_SUPPLYCOST"
		,"LOAD_TIMESTAMP"
		,"PS_AVAILQTY"
	)
	WITH "DIST_STG" AS 
	( 
		SELECT 
			  "STG_DIS_SRC"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
			, "STG_DIS_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, MIN("STG_DIS_SRC"."LOAD_DATE") AS "MIN_LOAD_TIMESTAMP"
		FROM "TPCH_SF1_STG"."PARTSUPP" "STG_DIS_SRC"
		GROUP BY  "STG_DIS_SRC"."LND_PARTSUPP_HKEY",  "STG_DIS_SRC"."LOAD_CYCLE_ID"
	)
	, "TEMP_TABLE_SET" AS 
	( 
		SELECT 
			  "STG_TEMP_SRC"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
			, "STG_TEMP_SRC"."PART_HKEY" AS "PART_HKEY"
			, "STG_TEMP_SRC"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
			, "STG_TEMP_SRC"."PS_PARTKEY" AS "PS_PARTKEY"
			, "STG_TEMP_SRC"."PS_SUPPKEY" AS "PS_SUPPKEY"
			, "STG_TEMP_SRC"."LOAD_DATE" AS "LOAD_DATE"
			, "STG_TEMP_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, TO_TIMESTAMP(NULL, 'DD/MM/YYYY HH24:MI:SS') AS "LOAD_END_DATE"
			, UPPER(MD5_HEX(COALESCE(RTRIM( REPLACE(COALESCE(TRIM( TO_CHAR("STG_TEMP_SRC"."PS_AVAILQTY")),'~'),'\\#','\\\\' || 
				'\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_TEMP_SRC"."PS_SUPPLYCOST")),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( "STG_TEMP_SRC"."PS_COMMENT"),'~'),'\\#','\\\\' || '\\#')|| '\\#' ||  REPLACE(COALESCE(TRIM( TO_CHAR("STG_TEMP_SRC"."LOAD_TIMESTAMP", 'DD/MM/YYYY HH24:MI:SS')),'~'),'\\#','\\\\' || '\\#')|| '\\#','\\#' || '~'),'~') )) AS "HASH_DIFF"
			, "STG_TEMP_SRC"."RECORD_TYPE" AS "RECORD_TYPE"
			, 'STG' AS "SOURCE"
			, 1 AS "ORIGIN_ID"
			, CASE WHEN "STG_TEMP_SRC"."JRN_FLAG" = 'D' THEN CAST('Y' AS VARCHAR) ELSE CAST('N' AS VARCHAR) END AS "DELETE_FLAG"
			, "STG_TEMP_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
			, "STG_TEMP_SRC"."PS_COMMENT" AS "PS_COMMENT"
			, "STG_TEMP_SRC"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
			, "STG_TEMP_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
			, "STG_TEMP_SRC"."PS_AVAILQTY" AS "PS_AVAILQTY"
		FROM "TPCH_SF1_STG"."PARTSUPP" "STG_TEMP_SRC"
		UNION ALL 
		SELECT 
			  "LDS_SRC"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
			, "LND_SRC"."PART_HKEY" AS "PART_HKEY"
			, "LND_SRC"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
			, "LDS_SRC"."PS_PARTKEY" AS "PS_PARTKEY"
			, "LDS_SRC"."PS_SUPPKEY" AS "PS_SUPPKEY"
			, "LDS_SRC"."LOAD_DATE" AS "LOAD_DATE"
			, "LDS_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, MAX("LDS_SRC"."LOAD_DATE")OVER(PARTITION BY "LDS_SRC"."LND_PARTSUPP_HKEY") AS "LOAD_END_DATE"
			, "LDS_SRC"."HASH_DIFF" AS "HASH_DIFF"
			, 'SAT' AS "RECORD_TYPE"
			, 'LDS' AS "SOURCE"
			, 0 AS "ORIGIN_ID"
			, "LDS_SRC"."DELETE_FLAG" AS "DELETE_FLAG"
			, "LDS_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
			, "LDS_SRC"."PS_COMMENT" AS "PS_COMMENT"
			, "LDS_SRC"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
			, "LDS_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
			, "LDS_SRC"."PS_AVAILQTY" AS "PS_AVAILQTY"
		FROM "TPCH_DV_FL"."LDS_TPCH_PARTSUPP" "LDS_SRC"
		INNER JOIN "TPCH_DV_FL"."LND_PARTSUPP" "LND_SRC" ON  "LDS_SRC"."LND_PARTSUPP_HKEY" = "LND_SRC"."LND_PARTSUPP_HKEY"
		INNER JOIN "DIST_STG" "DIST_STG" ON  "LDS_SRC"."LND_PARTSUPP_HKEY" = "DIST_STG"."LND_PARTSUPP_HKEY"
	)
	SELECT 
		  "TEMP_TABLE_SET"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
		, "TEMP_TABLE_SET"."PART_HKEY" AS "PART_HKEY"
		, "TEMP_TABLE_SET"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
		, "TEMP_TABLE_SET"."PS_PARTKEY" AS "PS_PARTKEY"
		, "TEMP_TABLE_SET"."PS_SUPPKEY" AS "PS_SUPPKEY"
		, "TEMP_TABLE_SET"."LOAD_DATE" AS "LOAD_DATE"
		, "TEMP_TABLE_SET"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "TEMP_TABLE_SET"."HASH_DIFF" AS "HASH_DIFF"
		, "TEMP_TABLE_SET"."RECORD_TYPE" AS "RECORD_TYPE"
		, "TEMP_TABLE_SET"."SOURCE" AS "SOURCE"
		, CASE WHEN "TEMP_TABLE_SET"."SOURCE" = 'STG' AND "TEMP_TABLE_SET"."DELETE_FLAG"::varchar || "TEMP_TABLE_SET"."HASH_DIFF"::varchar =
			LAG( "TEMP_TABLE_SET"."DELETE_FLAG"::varchar || "TEMP_TABLE_SET"."HASH_DIFF"::varchar,1)OVER(PARTITION BY "TEMP_TABLE_SET"."LND_PARTSUPP_HKEY" ORDER BY "TEMP_TABLE_SET"."LOAD_DATE","TEMP_TABLE_SET"."ORIGIN_ID")THEN 1 ELSE 0 END AS "EQUAL"
		, "TEMP_TABLE_SET"."DELETE_FLAG" AS "DELETE_FLAG"
		, "TEMP_TABLE_SET"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "TEMP_TABLE_SET"."PS_COMMENT" AS "PS_COMMENT"
		, "TEMP_TABLE_SET"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
		, "TEMP_TABLE_SET"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		, "TEMP_TABLE_SET"."PS_AVAILQTY" AS "PS_AVAILQTY"
	FROM "TEMP_TABLE_SET" "TEMP_TABLE_SET"
	WHERE  "TEMP_TABLE_SET"."SOURCE" = 'STG' OR("TEMP_TABLE_SET"."LOAD_DATE" = "TEMP_TABLE_SET"."LOAD_END_DATE" AND "TEMP_TABLE_SET"."SOURCE" = 'LDS')
	;
`} ).execute();

var LDS_INUR_TGT = snowflake.createStatement( {sqlText: `
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
	SELECT 
		  "LDS_TEMP_SRC_INUR"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
		, "LDS_TEMP_SRC_INUR"."PS_PARTKEY" AS "PS_PARTKEY"
		, "LDS_TEMP_SRC_INUR"."PS_SUPPKEY" AS "PS_SUPPKEY"
		, "LDS_TEMP_SRC_INUR"."LOAD_DATE" AS "LOAD_DATE"
		, "LDS_TEMP_SRC_INUR"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "LDS_TEMP_SRC_INUR"."HASH_DIFF" AS "HASH_DIFF"
		, "LDS_TEMP_SRC_INUR"."DELETE_FLAG" AS "DELETE_FLAG"
		, "LDS_TEMP_SRC_INUR"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "LDS_TEMP_SRC_INUR"."PS_COMMENT" AS "PS_COMMENT"
		, "LDS_TEMP_SRC_INUR"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
		, "LDS_TEMP_SRC_INUR"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		, "LDS_TEMP_SRC_INUR"."PS_AVAILQTY" AS "PS_AVAILQTY"
	FROM "TPCH_SF1_STG"."LDS_TPCH_PARTSUPP_TMP" "LDS_TEMP_SRC_INUR"
	WHERE  "LDS_TEMP_SRC_INUR"."SOURCE" = 'STG' AND "LDS_TEMP_SRC_INUR"."EQUAL" = 0
	;
`} ).execute();

return "Done.";$$;
 
 
