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


DROP VIEW IF EXISTS "TPCH_DV_BV"."SAT_TPCH_PART";
CREATE  VIEW "TPCH_DV_BV"."SAT_TPCH_PART"  AS 
	SELECT 
		  "DVT_SRC"."PART_HKEY" AS "PART_HKEY"
		, "DVT_SRC"."LOAD_DATE" AS "LOAD_DATE"
		, "DVT_SRC"."CDC_TIMESTAMP" AS "CDC_TIMESTAMP"
		, "DVT_SRC"."LOAD_CYCLE_ID" AS "LOAD_CYCLE_ID"
		, "DVT_SRC"."P_PARTKEY" AS "P_PARTKEY"
		, "DVT_SRC"."HASH_DIFF" AS "HASH_DIFF"
		, "DVT_SRC"."P_CONTAINER" AS "P_CONTAINER"
		, "DVT_SRC"."P_MFGR" AS "P_MFGR"
		, "DVT_SRC"."P_TYPE" AS "P_TYPE"
		, "DVT_SRC"."P_SIZE" AS "P_SIZE"
		, "DVT_SRC"."P_RETAILPRICE" AS "P_RETAILPRICE"
		, "DVT_SRC"."P_COMMENT" AS "P_COMMENT"
		, "DVT_SRC"."P_NAME" AS "P_NAME"
		, "DVT_SRC"."LOAD_TIMESTAMP" AS "LOAD_TIMESTAMP"
		, "DVT_SRC"."P_BRAND" AS "P_BRAND"
		, "DVT_SRC"."DELETE_FLAG" AS "DELETE_FLAG"
	FROM "TPCH_DV_FL"."SAT_TPCH_PART" "DVT_SRC"
	;

 
 
