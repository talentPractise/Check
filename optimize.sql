-- 1) Filter once
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
-- 2) Decide globally from the filtered slice
chosen AS (
  SELECT IF(COUNTIF(specialty_cd = '10301') > 0, '10301', '') AS specialty_chosen
  FROM base
)
-- 3) Keep only chosen specialty and aggregate
SELECT
  b.payment_method_cd,
  b.service_group_changed_ind,
  b.service_grouping_priority_nbr,
  MAX(b.rate) AS rate
FROM base b
JOIN chosen c ON TRUE
WHERE b.specialty_cd = c.specialty_chosen
GROUP BY
  b.payment_method_cd,
  b.service_group_changed_ind,
  b.service_grouping_priority_nbr;
