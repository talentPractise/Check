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
  AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
  AND PROVIDER_BUSINESS_GROUP_NBR IN (176236965, 727383733)
  AND CONTRACT_TYPE = 'D'
  AND SPECIALTY_CD = (
    SELECT CASE
      WHEN EXISTS (
        SELECT 1
        FROM CET_RATES
        WHERE SERVICE_CD = '99214'
          AND SERVICE_TYPE_CD = 'CPT4'
          AND PLACE_OF_SERVICE_CD = '11'
          AND (PRODUCT_CD = 'MPPO' OR PRODUCT_CD = 'ALL')
          AND PROVIDER_BUSINESS_GROUP_NBR IN (176236965, 727383733)
          AND CONTRACT_TYPE = 'D'
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


optimize the code
