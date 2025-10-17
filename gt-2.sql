WITH base AS (
  SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    specialty_cd,
    rate
  FROM CET_RATES
  WHERE
    SERVICE_CD = '99214'
    AND SERVICE_TYPE_CD = 'CPT4'
    AND PLACE_OF_SERVICE_CD = '11'
    AND PRODUCT_CD IN ('MPPO','ALL')
    AND PROVIDER_BUSINESS_GROUP_NBR IN (176236965, 727383733)
    AND CONTRACT_TYPE = 'D'
),
flag AS (
  SELECT EXISTS (SELECT 1 FROM base WHERE specialty_cd = '10301') AS has_10301
)
SELECT
  b.payment_method_cd,
  b.service_group_changed_ind,
  b.service_grouping_priority_nbr,
  MAX(b.rate) AS rate
FROM base b
JOIN flag f ON TRUE
WHERE b.specialty_cd = CASE WHEN f.has_10301 THEN '10301' ELSE '' END
GROUP BY
  b.payment_method_cd,
  b.service_group_changed_ind,
  b.service_grouping_priority_nbr;
