CREATE OR REPLACE PROCEDURE "SF_SAMPLE_PROC"."FMC_UPD_RUN_STATUS_BV_TPCH_DV"(P_LOAD_CYCLE_ID VARCHAR2,
P_SUCCESS_FLAG VARCHAR2)
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

Vaultspeed version: 5.3.1.1, generation date: 2023/06/17 03:45:20
DV_NAME: TPCH_DV - Release: TPCH_DV_1(1) - Comment: Release 1 of TPCH_DV - Release date: 2023/06/17 03:44:00, 
BV release: init(1) - Comment: initial release - Release date: 2023/06/17 01:44:13, 
SRC_NAME: TPCH_SF1 - Release: TPCH_SF1(1) - Comment: Release 1 of TPCH - Release date: 2023/06/17 03:37:07
 */



var HIST_UPD = snowflake.createStatement( {sqlText: `
	UPDATE "SF_SAMPLE_FMC"."FMC_LOADING_HISTORY" "HIST_UPD"
	SET 
		 "SUCCESS_FLAG" =  '` + P_SUCCESS_FLAG + `'::integer
		,"LOAD_END_DATE" =  CURRENT_TIMESTAMP
	WHERE "HIST_UPD"."LOAD_CYCLE_ID" =  '` + P_LOAD_CYCLE_ID + `'::integer
	;
`} ).execute();

return "Done.";$$;
 
 
