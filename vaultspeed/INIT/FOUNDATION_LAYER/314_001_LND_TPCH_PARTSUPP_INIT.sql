CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."LND_TPCH_PARTSUPP_INIT"()
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



var truncate_LND_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_DV_FL"."LND_PARTSUPP";
`} ).execute();


var LND_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_DV_FL"."LND_PARTSUPP"(
		 "LND_PARTSUPP_HKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"PART_HKEY"
		,"SUPPLIER_HKEY"
	)
	WITH "CHANGE_SET" AS 
	( 
		SELECT 
			  "STG_SRC1"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
			, "STG_SRC1"."LOAD_DATE" AS "LOAD_DATE"
			, "STG_SRC1"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, "STG_SRC1"."PART_HKEY" AS "PART_HKEY"
			, "STG_SRC1"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
		FROM "TPCH_SF1_STG"."PARTSUPP" "STG_SRC1"
	)
	, "MIN_LOAD_TIME" AS 
	( 
		SELECT 
			  "CHANGE_SET"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
			, "CHANGE_SET"."LOAD_DATE" AS "LOAD_DATE"
			, "CHANGE_SET"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
			, "CHANGE_SET"."PART_HKEY" AS "PART_HKEY"
			, "CHANGE_SET"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
			, ROW_NUMBER()OVER(PARTITION BY "CHANGE_SET"."LND_PARTSUPP_HKEY" ORDER BY "CHANGE_SET"."LOAD_CYCLE_ID",
				"CHANGE_SET"."LOAD_DATE") AS "DUMMY"
		FROM "CHANGE_SET" "CHANGE_SET"
	)
	SELECT 
		  "MIN_LOAD_TIME"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
		, "MIN_LOAD_TIME"."LOAD_DATE" AS "LOAD_DATE"
		, "MIN_LOAD_TIME"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "MIN_LOAD_TIME"."PART_HKEY" AS "PART_HKEY"
		, "MIN_LOAD_TIME"."SUPPLIER_HKEY" AS "SUPPLIER_HKEY"
	FROM "MIN_LOAD_TIME" "MIN_LOAD_TIME"
	WHERE  "MIN_LOAD_TIME"."DUMMY" = 1
	;
`} ).execute();

return "Done.";$$;
 
 
