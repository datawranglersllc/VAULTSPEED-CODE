CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."STG_DL_TPCH_PARTSUPP_INCR"()
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



var truncate_STG_DL_TGT = snowflake.createStatement( {sqlText: `
	TRUNCATE TABLE "TPCH_SF1_STG"."PARTSUPP";
`} ).execute();


var STG_DL_TGT = snowflake.createStatement( {sqlText: `
	INSERT INTO "TPCH_SF1_STG"."PARTSUPP"(
		 "LND_PARTSUPP_HKEY"
		,"PART_HKEY"
		,"SUPPLIER_HKEY"
		,"LOAD_DATE"
		,"LOAD_CYCLE_ID"
		,"CDC_TIMESTAMP"
		,"JRN_FLAG"
		,"RECORD_TYPE"
		,"PS_PARTKEY"
		,"PS_SUPPKEY"
		,"P_PARTKEY_FK_PSPARTKEY_BK"
		,"S_SUPPKEY_FK_PSSUPPKEY_BK"
		,"PS_AVAILQTY"
		,"PS_SUPPLYCOST"
		,"PS_COMMENT"
		,"LOAD_TIMESTAMP"
	)
	SELECT 
		  UPPER(MD5_HEX(  'TPCH' || '\\#' || "EXT_SRC"."P_PARTKEY_FK_PSPARTKEY_BK" || '\\#' || 'TPCH' || '\\#' || "EXT_SRC"."S_SUPPKEY_FK_PSSUPPKEY_BK" || 
			'\\#'  )) AS "LND_PARTSUPP_HKEY"
		, UPPER(MD5_HEX( 'TPCH' || '\\#' || "EXT_SRC"."P_PARTKEY_FK_PSPARTKEY_BK" || '\\#' )) AS "PART_HKEY"
		, UPPER(MD5_HEX( 'TPCH' || '\\#' || "EXT_SRC"."S_SUPPKEY_FK_PSSUPPKEY_BK" || '\\#' )) AS "SUPPLIER_HKEY"
		, "EXT_SRC"."LOAD_DATE" AS "LOAD_DATE"
		, "EXT_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "EXT_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "EXT_SRC"."JRN_FLAG" AS "JRN_FLAG"
		, "EXT_SRC"."RECORD_TYPE" AS "RECORD_TYPE"
		, "EXT_SRC"."PS_PARTKEY" AS "PS_PARTKEY"
		, "EXT_SRC"."PS_SUPPKEY" AS "PS_SUPPKEY"
		, "EXT_SRC"."P_PARTKEY_FK_PSPARTKEY_BK" AS "P_PARTKEY_FK_PSPARTKEY_BK"
		, "EXT_SRC"."S_SUPPKEY_FK_PSSUPPKEY_BK" AS "S_SUPPKEY_FK_PSSUPPKEY_BK"
		, "EXT_SRC"."PS_AVAILQTY" AS "PS_AVAILQTY"
		, "EXT_SRC"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
		, "EXT_SRC"."PS_COMMENT" AS "PS_COMMENT"
		, "EXT_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
	FROM "TPCH_SF1_EXT"."PARTSUPP" "EXT_SRC"
	INNER JOIN "TPCH_SF1_MTD"."MTD_EXCEPTION_RECORDS" "MEX_SRC" ON  "MEX_SRC"."RECORD_TYPE" = 'U'
	;
`} ).execute();

return "Done.";$$;
 
 
