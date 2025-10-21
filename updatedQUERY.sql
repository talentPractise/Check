WITH base AS (
    SELECT
        payment_method_cd,
        service_group_changed_ind,
        service_grouping_priority_nbr,
        specialty_cd,
        rate
    FROM CET_RATES
    WHERE
        SERVICE_CD = "99283"
        AND SERVICE_TYPE_CD = "CPT4"
        AND PLACE_OF_SERVICE_CD = "23"
        AND PRODUCT_CD IN ("MC", 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN UNNEST([769991465])
        AND CONTRACT_TYPE IN ('C', 'N')
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
