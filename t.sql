
-- Row Num 339 place_of service code does not exist in cet_rate table

-- claim based rate
SELECT MAX(RATE) AS RATE
FROM `prv_ps_ce_dec_hcb_dev.CET_CLAIM_BASED_AMOUNTS`
WHERE
    PROVIDER_IDENTIFICATION_NBR = "8697277"
    AND NETWORK_ID = "08164"
    AND PLACE_OF_SERVICE_CD = "22"
    AND SERVICE_CD = "85027"
    AND SERVICE_TYPE_CD = "CPT4";


-- provider table (if provider_type_cd)
SELECT DISTINCT PROVIDER_BUSINESS_GROUP_NBR, PROVIDER_BUSINESS_GROUP_SCORE_NBR, PROVIDER_IDENTIFICATION_NBR,PRODUCT_CD, SERVICE_LOCATION_NBR, NETWORK_ID, RATING_SYSTEM_CD, EPDB_GEOGRAPHIC_AREA_CD
FROM `prv_ps_ce_dec_hcb_dev.CET_PROVIDERS`
WHERE
    PROVIDER_IDENTIFICATION_NBR = 8697277
    AND NETWORK_ID = "08164"
    AND SERVICE_LOCATION_NBR = 1227427
    AND PROVIDER_TYPE_CD = "LB";



-- non standard rate (if provider_type)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM `prv_ps_ce_dec_hcb_dev.CET_RATES`
WHERE
    SERVICE_CD = "85027"
    AND SERVICE_TYPE_CD = "CPT4"
    AND PLACE_OF_SERVICE_CD = "81"
    AND (PRODUCT_CD = "MC" OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR = 451937557
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM `prv_ps_ce_dec_hcb_dev.CET_RATES`
                WHERE SERVICE_CD = "85027"
                    AND SERVICE_TYPE_CD = "CPT4"
                    AND PLACE_OF_SERVICE_CD = "81"
                    AND (PRODUCT_CD = "MC" OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR = 451937557
                    AND SPECIALTY_CD = "LB"
            )
            THEN "LB"
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;



-- checking cet_rate table
SELECT distinct PLACE_OF_SERVICE_CD
FROM `prv_ps_ce_dec_hcb_dev.CET_RATES`
WHERE SERVICE_CD = "85027"
    AND SERVICE_TYPE_CD = "CPT4"
    -- AND PLACE_OF_SERVICE_CD = "81"
    AND (PRODUCT_CD = "MC" OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR = 451937557
    -- AND SPECIALTY_CD = "LB"
