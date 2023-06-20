/*
 __     __          _ _                           _      __  ___  __   __   
 \ \   / /_ _ _   _| | |_ ___ ____   ___  ___  __| |     \ \/ _ \/ /  /_/   
  \ \ / / _` | | | | | __/ __|  _ \ / _ \/ _ \/ _` |      \/ / \ \/ /\      
   \ V / (_| | |_| | | |_\__ \ |_) |  __/  __/ (_| |      / / \/\ \/ /      
    \_/ \__,_|\__,_|_|\__|___/ .__/ \___|\___|\__,_|     /_/ \/_/\__/       
                             |_|                                            

Vaultspeed version: 5.3.1.1, generation date: 2023/06/17 01:44:50
DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
SRC_NAME: TPCH_SF1 - Release: TPCH_SF1(1) - Comment: Release 1 of TPCH - Release date: 2023/06/17 01:37:07
 */

/* DROP TABLES */

-- START

DROP TABLE IF EXISTS "TPCH_SF1_EXT"."PART" 
CASCADE
;
DROP TABLE IF EXISTS "TPCH_SF1_EXT"."PARTSUPP" 
CASCADE
;
DROP TABLE IF EXISTS "TPCH_SF1_EXT"."SUPPLIER" 
CASCADE
;

-- END


/* CREATE TABLES */

-- START


CREATE   TABLE "TPCH_SF1_EXT"."PART"
(
    "LOAD_DATE" TIMESTAMP_NTZ
   ,"LOAD_CYCLE_ID" INTEGER
   ,"CDC_TIMESTAMP" TIMESTAMP_NTZ
   ,"JRN_FLAG" VARCHAR
   ,"RECORD_TYPE" VARCHAR
   ,"P_PARTKEY" INTEGER
   ,"P_PARTKEY_BK" VARCHAR(1500)
   ,"P_NAME" VARCHAR
   ,"P_MFGR" VARCHAR
   ,"P_BRAND" VARCHAR
   ,"P_TYPE" VARCHAR
   ,"P_SIZE" INTEGER
   ,"P_CONTAINER" VARCHAR
   ,"P_RETAILPRICE" INTEGER
   ,"P_COMMENT" VARCHAR
   ,"LOAD_TIMESTAMP" TIMESTAMP_NTZ(9)
)
;

COMMENT ON TABLE "TPCH_SF1_EXT"."PART" IS 'DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
SRC_NAME: TPCH_SF1 - Release: TPCH_SF1(1) - Comment: Release 1 of TPCH - Release date: 2023/06/17 01:37:07';


CREATE   TABLE "TPCH_SF1_EXT"."PARTSUPP"
(
    "LOAD_DATE" TIMESTAMP_NTZ
   ,"LOAD_CYCLE_ID" INTEGER
   ,"CDC_TIMESTAMP" TIMESTAMP_NTZ
   ,"JRN_FLAG" VARCHAR
   ,"RECORD_TYPE" VARCHAR
   ,"PS_PARTKEY" INTEGER
   ,"PS_SUPPKEY" INTEGER
   ,"P_PARTKEY_FK_PSPARTKEY_BK" VARCHAR(1500)
   ,"S_SUPPKEY_FK_PSSUPPKEY_BK" VARCHAR(1500)
   ,"PS_AVAILQTY" INTEGER
   ,"PS_SUPPLYCOST" INTEGER
   ,"PS_COMMENT" VARCHAR
   ,"LOAD_TIMESTAMP" TIMESTAMP_NTZ(9)
)
;

COMMENT ON TABLE "TPCH_SF1_EXT"."PARTSUPP" IS 'DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
SRC_NAME: TPCH_SF1 - Release: TPCH_SF1(1) - Comment: Release 1 of TPCH - Release date: 2023/06/17 01:37:07';


CREATE   TABLE "TPCH_SF1_EXT"."SUPPLIER"
(
    "LOAD_DATE" TIMESTAMP_NTZ
   ,"LOAD_CYCLE_ID" INTEGER
   ,"CDC_TIMESTAMP" TIMESTAMP_NTZ
   ,"JRN_FLAG" VARCHAR
   ,"RECORD_TYPE" VARCHAR
   ,"S_SUPPKEY" INTEGER
   ,"S_SUPPKEY_BK" VARCHAR(1500)
   ,"S_NAME" VARCHAR
   ,"S_ADDRESS" VARCHAR
   ,"S_NATIONKEY" INTEGER
   ,"S_PHONE" VARCHAR
   ,"S_ACCTBAL" INTEGER
   ,"S_COMMENT" VARCHAR
   ,"LOAD_TIMESTAMP" TIMESTAMP_NTZ(9)
)
;

COMMENT ON TABLE "TPCH_SF1_EXT"."SUPPLIER" IS 'DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 01:44:00, 
SRC_NAME: TPCH_SF1 - Release: TPCH_SF1(1) - Comment: Release 1 of TPCH - Release date: 2023/06/17 01:37:07';


-- END


