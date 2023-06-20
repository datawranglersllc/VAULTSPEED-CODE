/*
 __     __          _ _                           _      __  ___  __   __   
 \ \   / /_ _ _   _| | |_ ___ ____   ___  ___  __| |     \ \/ _ \/ /  /_/   
  \ \ / / _` | | | | | __/ __|  _ \ / _ \/ _ \/ _` |      \/ / \ \/ /\      
   \ V / (_| | |_| | | |_\__ \ |_) |  __/  __/ (_| |      / / \/\ \/ /      
    \_/ \__,_|\__,_|_|\__|___/ .__/ \___|\___|\__,_|     /_/ \/_/\__/       
                             |_|                                            

Vaultspeed version: 5.3.1.1, generation date: 2023/06/17 01:44:50
DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00
 */

DROP TABLE IF EXISTS "SF_SAMPLE_FMC"."FMC_LOADING_HISTORY" 
CASCADE
;

CREATE   TABLE "SF_SAMPLE_FMC"."FMC_LOADING_HISTORY"
(
	"DAG_NAME" VARCHAR,
	"SRC_BK" VARCHAR,
	"LOAD_CYCLE_ID" INTEGER,
	"LOAD_DATE" TIMESTAMP_NTZ,
	"FMC_BEGIN_LW_TIMESTAMP" TIMESTAMP_NTZ,
	"FMC_END_LW_TIMESTAMP" TIMESTAMP_NTZ,
	"LOAD_START_DATE" TIMESTAMP_TZ,
	"LOAD_END_DATE" TIMESTAMP_TZ,
	"SUCCESS_FLAG" INTEGER
)
;

COMMENT ON TABLE "SF_SAMPLE_FMC"."FMC_LOADING_HISTORY" IS 'DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00';

