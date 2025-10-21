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
