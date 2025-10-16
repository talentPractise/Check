-- BigQuery SQL
WITH filtered AS (
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
    AND PRODUCT_CD IN ('MPPO', 'ALL')
    AND PROVIDER_Business_GROUP_NBR IN (176236995, 727383733)
    AND CONTRACT_TYPE = 'D'
    AND SPECIALTY_CD IN ('10301', '')          -- keep both, choose later
)
SELECT
  payment_method_cd,
  service_group_changed_ind,
  service_grouping_priority_nbr,
  -- Prefer 10301; if none, fall back to blank
  COALESCE(
    MAX(IF(specialty_cd = '10301', rate, NULL)),
    MAX(IF(specialty_cd = '',      rate, NULL))
  ) AS rate
FROM filtered
GROUP BY
  payment_method_cd,
  service_group_changed_ind,
  service_grouping_priority_nbr;
