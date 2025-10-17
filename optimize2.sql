WITH chosen AS (
  SELECT CASE
           WHEN EXISTS (
             SELECT 1
             FROM CET_RATES
             WHERE SPECIALTY_CD = '10301'
           )
           THEN '10301'
           ELSE ''
         END AS specialty_cd
)
SELECT
  r.payment_method_cd,
  r.service_group_changed_ind,
  r.service_grouping_priority_nbr,
  MAX(r.rate) AS rate
FROM CET_RATES r
JOIN chosen c ON TRUE
WHERE
  r.SERVICE_CD = '99214'
  AND r.SERVICE_TYPE_CD = 'CPT4'
  AND r.PLACE_OF_SERVICE_CD = '11'
  AND (r.PRODUCT_CD = 'MPPO' OR r.PRODUCT_CD = 'ALL')
  AND r.PROVIDER_BUSINESS_GROUP_NBR IN (176236965, 727383733)
  AND r.CONTRACT_TYPE = 'D'
  AND r.SPECIALTY_CD = c.specialty_cd
GROUP BY
  r.payment_method_cd,
  r.service_group_changed_ind,
  r.service_grouping_priority_nbr;
