-- @spec_code STRING, other params same as before
WITH pick AS (
  SELECT @spec_code AS chosen
  WHERE EXISTS (SELECT 1 FROM CET_RATES WHERE SPECIALTY_CD = @spec_code)
  UNION ALL
  SELECT '' 
  LIMIT 1
)
SELECT
  payment_method_cd,
  service_group_changed_ind,
  service_grouping_priority_nbr,
  MAX(rate) AS rate
FROM CET_RATES
WHERE SERVICE_CD = @service_cd
  AND SERVICE_TYPE_CD = @service_type_cd
  AND PLACE_OF_SERVICE_CD = @pos
  AND PRODUCT_CD = @product_cd
  AND PROVIDER_BUSINESS_GROUP_NBR IN UNNEST(@pbg_list)
  AND CONTRACT_TYPE IN ('C','N')
  AND SPECIALTY_CD = (SELECT chosen FROM pick)
GROUP BY
  payment_method_cd, service_group_changed_ind, service_grouping_priority_nbr;
