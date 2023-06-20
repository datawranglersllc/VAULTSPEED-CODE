CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."HUB_TPCH_PART_INCR"()
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



var HUB_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_DV_FL"."HUB_PART"(
		 "PART_HKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"P_PARTKEY_BK"
		,"SRC_BK"
	)
	WITH "CHANGE_SET" AS 
	( 
		SELECT 
			  "STG_SRC1"."PART_HKEY" AS "PART_HKEY"
			, "STG_SRC1"."LOAD_DATE" AS "LOAD_DATE"
			, "STG_SRC1"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, 0 AS "LOGPOSITION"
			, "STG_SRC1"."P_PARTKEY_BK" AS "P_PARTKEY_BK"
			, "STG_SRC1"."SRC_BK" AS "SRC_BK"
			, 0 AS "GENERAL_ORDER"
		FROM "TPCH_SF1_STG"."PART" "STG_SRC1"
		WHERE  "STG_SRC1"."RECORD_TYPE" = 'S'
	)
	, "MIN_LOAD_TIME" AS 
	( 
		SELECT 
			  "CHANGE_SET"."PART_HKEY" AS "PART_HKEY"
			, "CHANGE_SET"."LOAD_DATE" AS "LOAD_DATE"
			, "CHANGE_SET"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, "CHANGE_SET"."P_PARTKEY_BK" AS "P_PARTKEY_BK"
			, "CHANGE_SET"."SRC_BK" AS "SRC_BK"
			, ROW_NUMBER()OVER(PARTITION BY "CHANGE_SET"."PART_HKEY" ORDER BY "CHANGE_SET"."GENERAL_ORDER","CHANGE_SET"."LOAD_DATE",
				"CHANGE_SET"."LOGPOSITION") AS "DUMMY"
		FROM "CHANGE_SET" "CHANGE_SET"
	)
	SELECT 
		  "MIN_LOAD_TIME"."PART_HKEY" AS "PART_HKEY"
		, "MIN_LOAD_TIME"."LOAD_DATE" AS "LOAD_DATE"
		, "MIN_LOAD_TIME"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "MIN_LOAD_TIME"."P_PARTKEY_BK" AS "P_PARTKEY_BK"
		, "MIN_LOAD_TIME"."SRC_BK" AS "SRC_BK"
	FROM "MIN_LOAD_TIME" "MIN_LOAD_TIME"
	LEFT OUTER JOIN "TPCH_DV_FL"."HUB_PART" "HUB_SRC" ON  "MIN_LOAD_TIME"."PART_HKEY" = "HUB_SRC"."PART_HKEY"
	WHERE  "MIN_LOAD_TIME"."DUMMY" = 1 AND "HUB_SRC"."PART_HKEY" is NULL
	;
`} ).execute();

return "Done.";$$;
 
 
