-- Row Num: 291. BQ Rate = 8.05  Spanner Rate = 8.05   Allowed_Amt

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    specialty_cd,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7765082
    AND NETWORK_ID = '01472'
    AND SERVICE_LOCATION_NBR = 4645059
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM `prv_ps_ce_dec_hcb_dev.CET_PROVIDERS`
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 7765082
                    AND NETWORK_ID = '01472'
                    AND SERVICE_LOCATION_NBR = 4645059
                    AND SPECIALTY_CD = '20101'
            )
            THEN '20101'
            ELSE ''
        END
    );


-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM `prv_ps_ce_dec_hcb_dev.CET_RATES`
WHERE
    SERVICE_CD = '81025'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR in unnest([652164127,107326772])
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM `prv_ps_ce_dec_hcb_dev.CET_RATES`
                WHERE
                    SERVICE_CD = '81025'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR in unnest([652164127,107326772])
                    AND SPECIALTY_CD = '20101'
            )
            THEN '20101'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;






-- Row Num: 327    BQ Rate = 117.819 and   Spanner Rate = 117.819    retrieved_rate_unit_or_pct, calculated_rate_final


-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM cet_providers
WHERE
    PROVIDER_IDENTIFICATION_NBR = 5235644
    AND NETWORK_ID = '01344'
    AND SERVICE_LOCATION_NBR = 4822843
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM cet_providers
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 5235644
                    AND NETWORK_ID = '01344'
                    AND SERVICE_LOCATION_NBR = 4822843
                    AND SPECIALTY_CD = '10201'
            )
            THEN '10201'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM cet_rates
WHERE
    SERVICE_CD = '99491'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MEPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR = 920446498
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM cet_rates
                WHERE
                    SERVICE_CD = '99491'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MEPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR = 920446498
                    AND SPECIALTY_CD = '10201'
            )
            THEN '10201'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Row Num: 416 BQ Rate=218.  Spanner Rate=218              retrieved_rate_unit_or_pct, calculated_rate_final


-- cet_provider table (elif provider_type_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 5540965
    AND NETWORK_ID = '00173'
    AND SERVICE_LOCATION_NBR = 5024387
    AND PROVIDER_TYPE_CD = 'UC';



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM cet_rates
WHERE
    SERVICE_CD = 'S9083'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '20'
    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =85151710
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM cet_rates
                WHERE
                    SERVICE_CD = 'S9083'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '20'
                    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =85151710
                    AND SPECIALTY_CD = 'UC'
            )
            THEN 'UC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Row Num: 431 BQ Rate = 236.03 and Spanner Rate = 236.03

-- cet_provider table (elif provider_type_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 5540965
    AND NETWORK_ID = '00173'
    AND SERVICE_LOCATION_NBR = 5024387
    AND PROVIDER_TYPE_CD = 'UC';



-- non standard rate (if provider_type_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM cet_rates
WHERE
    SERVICE_CD = '76830'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MEPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =954437311
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM cet_rates
                WHERE
                    SERVICE_CD = '76830'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MEPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =954437311
                    AND SPECIALTY_CD = 'NP'
            )
            THEN 'NP'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Row Num: 478 BQ Rate = 104.21 and Spaner Rate = 104.21            Allowed_Amt

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 9415884
    AND NETWORK_ID = '00398'
    AND SERVICE_LOCATION_NBR = 2563105
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 9415884
                    AND NETWORK_ID = '00398'
                    AND SERVICE_LOCATION_NBR = 2563105
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    );




-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99391'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR in UNNEST([244678133,463638263])
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '99391'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR in UNNEST([244678133,463638263])
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;



-- Row Num: 554 BQ Rate = 199.34   and Spanner Rate = 199.34           retrieved_rate_unit_or_pct, calculated_rate_final
-- cet_provider table (elif provider_type_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7168790
    AND NETWORK_ID = '00447'
    AND SERVICE_LOCATION_NBR = 1682595
    AND PROVIDER_TYPE_CD = 'RC';



-- non standard rate (if provider_type_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '76830'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =444775063
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '76830'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =444775063
                    AND SPECIALTY_CD = 'RC'
            )
            THEN 'RC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Row Num: 601 BQ Rate =. 34.959   and Spanner Rate = 34.959       retrieved_rate_unit_or_pct

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7713675
    AND NETWORK_ID = '00437'
    AND SERVICE_LOCATION_NBR = 6956244
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 7713675
                    AND NETWORK_ID = '00437'
                    AND SERVICE_LOCATION_NBR = 6956244
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90461'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR = 683414246
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '90461'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =683414246
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;




-- Row Num: 700  BQ Rate = 271.64   and Spanner Rate = 271.64           retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7712368
    AND NETWORK_ID = '00385'
    AND SERVICE_LOCATION_NBR = 4836453
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 7712368
                    AND NETWORK_ID = '00385'
                    AND SERVICE_LOCATION_NBR = 4836453
                    AND SPECIALTY_CD = '11001'
            )
            THEN '11001'
            ELSE ''
        END
    );


-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99233'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '21'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =461370498
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '99233'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '21'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =461370498
                    AND SPECIALTY_CD = '11001'
            )
            THEN '11001'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Row Num: 723  BQ Rate = 154.94  and   Spanner Rate = 154.94

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 8368864
    AND NETWORK_ID = '03780'
    AND SERVICE_LOCATION_NBR = 4153418
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 8368864
                    AND NETWORK_ID = '03780'
                    AND SERVICE_LOCATION_NBR = 4153418
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99214'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =377895409
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '99214'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =377895409
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;



-- Row Num: 728. BQ Rate = 5.02   and.  Spanner Rate = 5.02                 retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7727548
    AND NETWORK_ID = '00098'
    AND SERVICE_LOCATION_NBR = 890166
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 7727548
                    AND NETWORK_ID = '00098'
                    AND SERVICE_LOCATION_NBR = 890166
                    AND SPECIALTY_CD = '20101'
            )
            THEN '20101'
            ELSE ''
        END
    );


-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96160'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =209958436
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '96160'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =209958436
                    AND SPECIALTY_CD = '20101'
            )
            THEN '20101'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- ROW NUM: 742.  Rate not retrieved network_id, service_location_nbr and provider_type_cd does not exist
-- cet_provider table (elif provider_type_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM `prv_ps_ce_dec_hcb_dev.CET_PROVIDERS`
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7539690
    -- AND NETWORK_ID = '00606'
    -- AND SERVICE_LOCATION_NBR = 158112
    -- AND PROVIDER_TYPE_CD = 'PSH';



-- Row Num: 757.  BQ Rate = 173.41425  and Spanner Rate = 173.41425         retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7333594
    AND NETWORK_ID = '00357'
    AND SERVICE_LOCATION_NBR = 4071677
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 7333594
                    AND NETWORK_ID = '00357'
                    AND SERVICE_LOCATION_NBR = 4071677
                    AND SPECIALTY_CD = '11002'
            )
            THEN '11002'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99213'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =996825917
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '99213'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =996825917
                    AND SPECIALTY_CD = '11002'
            )
            THEN '11002'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;





-- Row Num: 821  BQ Rate = 6.12      and Spanner Rate = 6.12            Allowed_Amt 

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 4998887
    AND NETWORK_ID = '00639'
    AND SERVICE_LOCATION_NBR = 2156779
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 4998887
                    AND NETWORK_ID = '00639'
                    AND SERVICE_LOCATION_NBR = 2156779
                    AND SPECIALTY_CD = '20101'
            )
            THEN '20101'
            ELSE ''
        END
    );


-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '81003'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MEPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR in UNNEST([190737108,510636722])
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '81003'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MEPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR in UNNEST([190737108,510636722])
                    AND SPECIALTY_CD = '20101'
            )
            THEN '20101'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;




-- Row Num: 823  BQ Rate = 141      and Spanner Rate = 141   retrieved_rate_unit_or_pct, calculated_rate_final
-- cet_provider table (elif provider_type_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 9731502
    AND NETWORK_ID = '00447'
    AND SERVICE_LOCATION_NBR = 6605677
    AND PROVIDER_TYPE_CD = 'OMP';




-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '91321'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR = 646492803
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '91321'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR = 646492803
                    AND SPECIALTY_CD = 'OMP'
            )
            THEN 'OMP'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;





-- Row Num: 855 BQ Rate = 382.52           and Spanner Rate = 382.52        retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 8715650
    AND NETWORK_ID = '00190'
    AND SERVICE_LOCATION_NBR = 8591815
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 8715650
                    AND NETWORK_ID = '00190'
                    AND SERVICE_LOCATION_NBR = 8591815
                    AND SPECIALTY_CD = '10701'
            )
            THEN '10701'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99284'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '23'
    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =844928109
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '99284'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '23'
                    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =844928109
                    AND SPECIALTY_CD = '10701'
            )
            THEN '10701'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;




-- Row Num: 857.  BQ Rate = 68.8608     and Spanner Rate = 68.8608          retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 7258128
    AND NETWORK_ID = '00357'
    AND SERVICE_LOCATION_NBR = 5394720
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 7258128
                    AND NETWORK_ID = '00357'
                    AND SERVICE_LOCATION_NBR = 5394720
                    AND SPECIALTY_CD = '10301'
            )
            THEN '10301'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '93000'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =211381947
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '93000'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =211381947
                    AND SPECIALTY_CD = '10301'
            )
            THEN '10301'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;




-- Row Num: 891.   BQ Rate = 49.5         and Spanner Rate = 49.5       retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 4720723
    AND NETWORK_ID = '00391'
    AND SERVICE_LOCATION_NBR = 48221
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 4720723
                    AND NETWORK_ID = '00391'
                    AND SERVICE_LOCATION_NBR = 48221
                    AND SPECIALTY_CD = '90353'
            )
            THEN '90353'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90661'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =733827850
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '90661'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =733827850
                    AND SPECIALTY_CD = '90353'
            )
            THEN '90353'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;




-- Row Num: 1023.  BQ Rate = 166.1208    and Spanner Rate = 166.1208        retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 9400970
    AND NETWORK_ID = '00385'
    AND SERVICE_LOCATION_NBR = 712831
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 9400970
                    AND NETWORK_ID = '00385'
                    AND SERVICE_LOCATION_NBR = 712831
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99381'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =516002618
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '99381'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =516002618
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;





-- Row Num: 1074.  BQ Rate = 4185.36     and Spanner Rate = 4185.36   Claim_based_amount
-- Claim Based
SELECT MAX(RATE) AS RATE
FROM CET_CLAIM_BASED_AMOUNTS
WHERE
    PROVIDER_IDENTIFICATION_NBR = "6543355"
    AND NETWORK_ID = "00248"
    AND PLACE_OF_SERVICE_CD = '23'
    AND SERVICE_CD = '99283'
    AND SERVICE_TYPE_CD = 'CPT4';



-- Row Num: 1128.  BQ Rate = 12.44          and Spanner Rate = 12.44      retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 4252081
    AND NETWORK_ID = '00098'
    AND SERVICE_LOCATION_NBR = 2790243
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 4252081
                    AND NETWORK_ID = '00098'
                    AND SERVICE_LOCATION_NBR = 2790243
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    );



-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '92551'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =98865273
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '92551'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =98865273
                    AND SPECIALTY_CD = '10401'
            )
            THEN '10401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;



-- Row Num: 1176  BQ Rate =236.7386   and Spanner Rate = 236.7386      retrieved_rate_unit_or_pct, calculated_rate_final

-- cet_provider table (if specialty_cd)
SELECT DISTINCT
    PROVIDER_BUSINESS_GROUP_NBR,
    PROVIDER_BUSINESS_GROUP_SCORE_NBR,
    PROVIDER_IDENTIFICATION_NBR,
    PRODUCT_CD,
    SERVICE_LOCATION_NBR,
    NETWORK_ID,
    RATING_SYSTEM_CD,
    EPDB_GEOGRAPHIC_AREA_CD
FROM CET_PROVIDERS
WHERE
    PROVIDER_IDENTIFICATION_NBR = 4187775
    AND NETWORK_ID = '02152'
    AND SERVICE_LOCATION_NBR = 7830924
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_PROVIDERS
                WHERE
                    PROVIDER_IDENTIFICATION_NBR = 4187775
                    AND NETWORK_ID = '02152'
                    AND SERVICE_LOCATION_NBR = 7830924
                    AND SPECIALTY_CD = '10201'
            )
            THEN '10201'
            ELSE ''
        END
    );


-- non standard rate (if specialty_cd)
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99396'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR =579481643
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE
                    SERVICE_CD = '99396'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR =579481643
                    AND SPECIALTY_CD = '10201'
            )
            THEN '10201'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;
