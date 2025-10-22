-- q-1
SELECT
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr,
    MAX(rate) AS rate
FROM (
    SELECT
        *,
        MAX(CASE WHEN SPECIALTY_CD = @providerspecialtycode THEN 1 ELSE 0 END)
            OVER () AS specialty_exists
    FROM CET_RATES
    WHERE
        SERVICE_CD = @servicecd
        AND SERVICE_TYPE_CD = @servicetype
        AND PLACE_OF_SERVICE_CD = @placeofservice
        AND (PRODUCT_CD = @productcd OR PRODUCT_CD = 'ALL')
        AND PROVIDER_BUSINESS_GROUP_NBR IN UNNEST(@providerbusinessgroupnbr)
        AND CONTRACT_TYPE IN ('C', 'N')
) src
WHERE
    (specialty_exists = 1 AND SPECIALTY_CD = @providerspecialtycode)
    OR (specialty_exists = 0 AND SPECIALTY_CD = '')
GROUP BY
    payment_method_cd,
    service_group_changed_ind,
    service_grouping_priority_nbr;




-- q-2
SELECT
  payment_method_cd,
  service_group_changed_ind,
  service_grouping_priority_nbr,
  MAX(rate) AS rate
FROM CET_RATES
WHERE
  SERVICE_CD = @servicecd
  AND SERVICE_TYPE_CD = @servicetype
  AND PLACE_OF_SERVICE_CD = @placeofservice
  AND (PRODUCT_CD = @productcd OR PRODUCT_CD = 'ALL')
  AND PROVIDER_BUSINESS_GROUP_NBR IN UNNEST(@providerbusinessgroupnbr)
  AND CONTRACT_TYPE IN ('C', 'N')
  AND SPECIALTY_CD = (
    SELECT
      COALESCE(
        MAX(CASE WHEN SPECIALTY_CD = @providerspecialtycode THEN @providerspecialtycode END),
        ''
      )
    FROM CET_RATES
    WHERE
      SERVICE_CD = @servicecd
      AND SERVICE_TYPE_CD = @servicetype
      AND PLACE_OF_SERVICE_CD = @placeofservice
      AND (PRODUCT_CD = @productcd OR PRODUCT_CD = 'ALL')
      AND PROVIDER_BUSINESS_GROUP_NBR IN UNNEST(@providerbusinessgroupnbr)
      AND CONTRACT_TYPE IN ('C', 'N')
  )
GROUP BY
  payment_method_cd,
  service_group_changed_ind,
  service_grouping_priority_nbr;
