/*
 __     __          _ _                           _      __  ___  __   __   
 \ \   / /_ _ _   _| | |_ ___ ____   ___  ___  __| |     \ \/ _ \/ /  /_/   
  \ \ / / _` | | | | | __/ __|  _ \ / _ \/ _ \/ _` |      \/ / \ \/ /\      
   \ V / (_| | |_| | | |_\__ \ |_) |  __/  __/ (_| |      / / \/\ \/ /      
    \_/ \__,_|\__,_|_|\__|___/ .__/ \___|\___|\__,_|     /_/ \/_/\__/       
                             |_|                                            

Vaultspeed version: 5.3.1.1, generation date: 2023/06/17 01:44:50
DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
BV release: init(1) - Comment: initial release - Release date: 2023/06/17 01:44:13
 */

/* DROP TABLES */

-- START
DROP TABLE IF EXISTS "SF_SAMPLE_FMC"."FMC_BV_LOADING_WINDOW_TABLE" 
CASCADE
;
DROP TABLE IF EXISTS "SF_SAMPLE_FMC"."LOAD_CYCLE_INFO" 
CASCADE
;
DROP TABLE IF EXISTS "SF_SAMPLE_FMC"."DV_LOAD_CYCLE_INFO" 
CASCADE
;

-- END


/* CREATE TABLES */

-- START

CREATE   TABLE "SF_SAMPLE_FMC"."FMC_BV_LOADING_WINDOW_TABLE"
(
	"FMC_BEGIN_LW_TIMESTAMP" TIMESTAMP_NTZ,
	"FMC_END_LW_TIMESTAMP" TIMESTAMP_NTZ
)
;

COMMENT ON TABLE "SF_SAMPLE_FMC"."FMC_BV_LOADING_WINDOW_TABLE" IS 'DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
BV release: init(1) - Comment: initial release - Release date: 2023/06/17 01:44:13';


CREATE   TABLE "SF_SAMPLE_FMC"."LOAD_CYCLE_INFO"
(
	"LOAD_CYCLE_ID" INTEGER,
	"LOAD_DATE" TIMESTAMP_NTZ
)
;

COMMENT ON TABLE "SF_SAMPLE_FMC"."LOAD_CYCLE_INFO" IS 'DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
BV release: init(1) - Comment: initial release - Release date: 2023/06/17 01:44:13';


CREATE   TABLE "SF_SAMPLE_FMC"."DV_LOAD_CYCLE_INFO"
(
	"DV_LOAD_CYCLE_ID" INTEGER
)
;

COMMENT ON TABLE "SF_SAMPLE_FMC"."DV_LOAD_CYCLE_INFO" IS 'DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
BV release: init(1) - Comment: initial release - Release date: 2023/06/17 01:44:13';


-- END


