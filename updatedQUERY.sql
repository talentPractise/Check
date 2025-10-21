-- Query 1.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99315'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '31'
        AND PRODUCT_CD IN ('MC', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (48709360)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11010'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11010'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 1.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99315'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '31'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (48709360)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99315'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '31'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (48709360)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = '11010'
            )
            THEN '11010'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 2.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G0018'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '56'
        AND PRODUCT_CD IN ('HMOAVN', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (600389633)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PE'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PE'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 2.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G0018'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '56'
    AND (PRODUCT_CD = 'HMOAVN' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (600389633)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G0018'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '56'
                    AND (PRODUCT_CD = 'HMOAVN' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (600389633)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = 'PE'
            )
            THEN 'PE'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 3.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G2088'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '2'
        AND PRODUCT_CD IN ('QPOS', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (749707569)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PAB'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PAB'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 3.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G2088'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '2'
    AND (PRODUCT_CD = 'QPOS' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (749707569)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G2088'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '2'
                    AND (PRODUCT_CD = 'QPOS' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (749707569)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = 'PAB'
            )
            THEN 'PAB'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 4.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G2086'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '2'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (741126074)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '90001'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '90001'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 4.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G2086'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '2'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (741126074)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G2086'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '2'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (741126074)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '90001'
            )
            THEN '90001'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 5.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99308'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '31'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (599359979)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11001'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11001'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 5.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99308'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '31'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (599359979)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99308'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '31'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (599359979)
                    AND CONTRACT_TYPE = 'D'
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


-- Query 6.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99315'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '31'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (362800172)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11001'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11001'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 6.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99315'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '31'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (362800172)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99315'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '31'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (362800172)
                    AND CONTRACT_TYPE = 'D'
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


-- Query 7.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99347'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '13'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (50415604)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '90401'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '90401'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 7.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99347'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '13'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (50415604)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99347'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '13'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (50415604)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '90401'
            )
            THEN '90401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 8.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G0018'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '56'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (749165091)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PE'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PE'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 8.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G0018'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '56'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (749165091)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G0018'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '56'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (749165091)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PE'
            )
            THEN 'PE'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 9.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99316'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '31'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (477722375)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '90401'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '90401'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 9.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99316'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '31'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (477722375)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99316'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '31'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (477722375)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '90401'
            )
            THEN '90401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 10.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99315'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '31'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (389852037)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PAB'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PAB'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 10.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99315'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '31'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (389852037)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99315'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '31'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (389852037)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PAB'
            )
            THEN 'PAB'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 11.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99304'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '31'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (965167835)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 11.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99304'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '31'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (965167835)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99304'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '31'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (965167835)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 12.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99281'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '23'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (828469436)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 12.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99281'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '23'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (828469436)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99281'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '23'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (828469436)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 13.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G2087'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '2'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (542827413)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PC'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PC'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 13.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G2087'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '2'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (542827413)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G2087'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '2'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (542827413)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PC'
            )
            THEN 'PC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 14.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G2087'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '2'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (815121846)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11001'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11001'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 14.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G2087'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '2'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (815121846)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G2087'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '2'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (815121846)
                    AND CONTRACT_TYPE = 'D'
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


-- Query 15.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96112'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('MPPO', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (773262363)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '90401'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '90401'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 15.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96112'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (773262363)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96112'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (773262363)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = '90401'
            )
            THEN '90401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 16.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96132'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('MC', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (231409883)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PC'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PC'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 16.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96132'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (231409883)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96132'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (231409883)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = 'PC'
            )
            THEN 'PC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 17.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99213'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('MEPO', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (451005961)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11005'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11005'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 17.2
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
    AND (PRODUCT_CD = 'MEPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (451005961)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99213'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MEPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (451005961)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = '11005'
            )
            THEN '11005'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 18.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99212'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('TRICR', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (707888813)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11001'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11001'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 18.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99212'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'TRICR' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (707888813)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99212'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'TRICR' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (707888813)
                    AND CONTRACT_TYPE = 'C'
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


-- Query 19.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99203'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('MEPOS', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (389553071)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PAB'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PAB'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 19.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99203'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MEPOS' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (389553071)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99203'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MEPOS' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (389553071)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = 'PAB'
            )
            THEN 'PAB'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 20.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99409'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('SLFIN', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (96490810)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PN'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PN'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 20.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99409'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'SLFIN' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (96490810)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99409'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'SLFIN' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (96490810)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = 'PN'
            )
            THEN 'PN'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 21.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99242'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('MPPO', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (356037084)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'CP'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'CP'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 21.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99242'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (356037084)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99242'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (356037084)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = 'CP'
            )
            THEN 'CP'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 22.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99493'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('EAP', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (93433805)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 22.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99493'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'EAP' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (93433805)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99493'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'EAP' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (93433805)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 23.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99493'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('MCAID', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (328644007)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '90401'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '90401'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 23.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99493'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MCAID' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (328644007)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99493'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MCAID' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (328644007)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = '90401'
            )
            THEN '90401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 24.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99417'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('USACC', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (400218736)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '90401'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '90401'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 24.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99417'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'USACC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (400218736)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99417'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'USACC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (400218736)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = '90401'
            )
            THEN '90401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 25.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96132'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('MC', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (326346147)
        AND CONTRACT_TYPE = 'C'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PN'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PN'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 25.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96132'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (326346147)
    AND CONTRACT_TYPE = 'C'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96132'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'MC' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (326346147)
                    AND CONTRACT_TYPE = 'C'
                    AND SPECIALTY_CD = 'PN'
            )
            THEN 'PN'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 26.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '97545'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (827132892)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'DC'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'DC'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 26.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '97545'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (827132892)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '97545'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (827132892)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'DC'
            )
            THEN 'DC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 27.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96112'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (393598400)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11011'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11011'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 27.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96112'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (393598400)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96112'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (393598400)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11011'
            )
            THEN '11011'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 28.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99215'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (481504325)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PC'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PC'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 28.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99215'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (481504325)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99215'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (481504325)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PC'
            )
            THEN 'PC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 29.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99213'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (265539547)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'CP'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'CP'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 29.2
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
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (265539547)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99213'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (265539547)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'CP'
            )
            THEN 'CP'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 30.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96137'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (182757185)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 30.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96137'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (182757185)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96137'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (182757185)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 31.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '90849'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (599196914)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PE'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PE'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 31.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90849'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (599196914)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '90849'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (599196914)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PE'
            )
            THEN 'PE'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 32.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99058'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (676706814)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PAB'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PAB'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 32.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99058'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (676706814)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99058'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (676706814)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PAB'
            )
            THEN 'PAB'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 33.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96138'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (656334317)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'LPC'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'LPC'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 33.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96138'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (656334317)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96138'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (656334317)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'LPC'
            )
            THEN 'LPC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 34.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '90836'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (246135911)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11007'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11007'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 34.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90836'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (246135911)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '90836'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (246135911)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11007'
            )
            THEN '11007'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 35.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '90901'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (512684327)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 35.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90901'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (512684327)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '90901'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (512684327)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 36.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96136'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (625381316)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 36.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96136'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (625381316)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96136'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (625381316)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 37.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '90880'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (532331386)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 37.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90880'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (532331386)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '90880'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (532331386)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 38.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '90839'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (327779430)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'LPC'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'LPC'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 38.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90839'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (327779430)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '90839'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (327779430)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'LPC'
            )
            THEN 'LPC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 39.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G0022'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (688173724)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 39.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G0022'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (688173724)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G0022'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (688173724)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 40.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99203'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (388354010)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PN'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PN'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 40.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99203'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (388354010)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99203'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (388354010)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PN'
            )
            THEN 'PN'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 41.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99244'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (256507669)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 41.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99244'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (256507669)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99244'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (256507669)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 42.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G0554'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (167036730)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11011'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11011'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 42.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G0554'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (167036730)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G0554'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (167036730)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11011'
            )
            THEN '11011'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 43.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99202'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (749019021)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11001'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11001'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 43.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99202'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (749019021)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99202'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (749019021)
                    AND CONTRACT_TYPE = 'D'
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


-- Query 44.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '90838'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (655347234)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11007'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11007'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 44.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90838'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (655347234)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '90838'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (655347234)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11007'
            )
            THEN '11007'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 45.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99484'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (478939163)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '90401'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '90401'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 45.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99484'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (478939163)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99484'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (478939163)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '90401'
            )
            THEN '90401'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 46.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99245'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (901975586)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PAB'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PAB'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 46.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99245'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (901975586)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99245'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (901975586)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PAB'
            )
            THEN 'PAB'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 47.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '90791'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (974959123)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'PC'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'PC'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 47.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '90791'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (974959123)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '90791'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (974959123)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'PC'
            )
            THEN 'PC'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 48.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '99409'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (895774961)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = 'CP'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN 'CP'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 48.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '99409'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (895774961)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '99409'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (895774961)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = 'CP'
            )
            THEN 'CP'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 49.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = 'G0017'
        AND SERVICE_TYPE_CD = 'HCPC'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (220973385)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11004'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11004'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 49.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = 'G0017'
    AND SERVICE_TYPE_CD = 'HCPC'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (220973385)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = 'G0017'
                    AND SERVICE_TYPE_CD = 'HCPC'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (220973385)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11004'
            )
            THEN '11004'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;


-- Query 50.1
WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = '96112'
        AND SERVICE_TYPE_CD = 'CPT4'
        AND PLACE_OF_SERVICE_CD = '11'
        AND PRODUCT_CD IN ('ALL', 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN (263161679)
        AND CONTRACT_TYPE = 'D'
),
flag AS (
    SELECT EXISTS (
        SELECT 1
        FROM base
        WHERE specialty_cd = '11005'
    ) AS has_specialty_cd
)
SELECT
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr,
    MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE
    b.specialty_cd = CASE
        WHEN f.has_specialty_cd THEN '11005'
        ELSE ''
    END
GROUP BY
    b.payment_method_cd,
    b.service_group_changed_ind,
    b.service_grouping_priority_nbr;


-- Query 50.2
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM CET_RATES
WHERE
    SERVICE_CD = '96112'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (263161679)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD = (
        SELECT CASE
            WHEN EXISTS (
                SELECT 1
                FROM CET_RATES
                WHERE SERVICE_CD = '96112'
                    AND SERVICE_TYPE_CD = 'CPT4'
                    AND PLACE_OF_SERVICE_CD = '11'
                    AND (PRODUCT_CD = 'ALL' OR PRODUCT_CD = 'ALL')
                    AND PROVIDER_BUSINESS_GROUP_NBR IN (263161679)
                    AND CONTRACT_TYPE = 'D'
                    AND SPECIALTY_CD = '11005'
            )
            THEN '11005'
            ELSE ''
        END
    )
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;

