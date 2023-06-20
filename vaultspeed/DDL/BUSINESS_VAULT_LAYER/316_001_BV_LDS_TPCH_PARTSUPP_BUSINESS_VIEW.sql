/*
 __     __          _ _                           _      __  ___  __   __   
 \ \   / /_ _ _   _| | |_ ___ ____   ___  ___  __| |     \ \/ _ \/ /  /_/   
  \ \ / / _` | | | | | __/ __|  _ \ / _ \/ _ \/ _` |      \/ / \ \/ /\      
   \ V / (_| | |_| | | |_\__ \ |_) |  __/  __/ (_| |      / / \/\ \/ /      
    \_/ \__,_|\__,_|_|\__|___/ .__/ \___|\___|\__,_|     /_/ \/_/\__/       
                             |_|                                            

Vaultspeed version: 5.3.1.1, generation date: 2023/06/17 03:45:20
DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 03:44:00, 
BV release: init(1) - Comment: initial release - Release date: 2023/06/17 01:44:13, 
SRC_NAME: TPCH_SF1 - Release: TPCH_SF1(1) - Comment: Release 1 of TPCH - Release date: 2023/06/17 03:37:07
 */


DROP VIEW IF EXISTS "TPCH_DV_BV"."LDS_TPCH_PARTSUPP";
CREATE  VIEW "TPCH_DV_BV"."LDS_TPCH_PARTSUPP"  AS 
	SELECT 
		  "DVT_SRC"."LND_PARTSUPP_HKEY" AS "LND_PARTSUPP_HKEY"
		, "DVT_SRC"."LOAD_DATE" AS "LOAD_DATE"
		, "DVT_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "DVT_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "DVT_SRC"."PS_PARTKEY" AS "PS_PARTKEY"
		, "DVT_SRC"."PS_SUPPKEY" AS "PS_SUPPKEY"
		, "DVT_SRC"."HASH_DIFF" AS "HASH_DIFF"
		, "DVT_SRC"."PS_COMMENT" AS "PS_COMMENT"
		, "DVT_SRC"."PS_SUPPLYCOST" AS "PS_SUPPLYCOST"
		, "DVT_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		, "DVT_SRC"."PS_AVAILQTY" AS "PS_AVAILQTY"
		, "DVT_SRC"."DELETE_FLAG" AS "DELETE_FLAG"
	FROM "TPCH_DV_FL"."LDS_TPCH_PARTSUPP" "DVT_SRC"
	;

 
 
