-- params: @service_cd, @service_type_cd, @place_of_service_cd
WITH base AS (
  SELECT
    PROVIDER_BUSINESS_GROUP_NBR,
    PAYMENT_METHOD_CD,
    SERVICE_CD,
    SERVICE_TYPE_CD,
    PLACE_OF_SERVICE_CD,
    SERVICE_GROUPING_PRIORITY_NBR,
    SERVICE_GROUP_CHANGED_IND,
    RATE,
    CONTRACT_TYPE
  FROM CET_RATES
  WHERE SERVICE_CD = @service_cd
    AND SERVICE_TYPE_CD = @service_type_cd
    AND PLACE_OF_SERVICE_CD = @place_of_service_cd
    AND CONTRACT_TYPE = 'N'
),
w AS (
  SELECT
    b.*,
    MAX(b.RATE) OVER (
      PARTITION BY
        b.PROVIDER_BUSINESS_GROUP_NBR,
        b.PAYMENT_METHOD_CD,
        b.SERVICE_CD,
        b.SERVICE_TYPE_CD,
        b.PLACE_OF_SERVICE_CD
    ) AS grp_max_rate,
    COUNT(*) OVER (
      PARTITION BY
        b.PROVIDER_BUSINESS_GROUP_NBR,
        b.PAYMENT_METHOD_CD,
        b.SERVICE_CD,
        b.SERVICE_TYPE_CD,
        b.PLACE_OF_SERVICE_CD,
        b.RATE
    ) AS cnt_at_rate
  FROM base b
)
SELECT
  PROVIDER_BUSINESS_GROUP_NBR,
  PAYMENT_METHOD_CD,
  SERVICE_CD,
  SERVICE_TYPE_CD,
  PLACE_OF_SERVICE_CD,
  SERVICE_GROUPING_PRIORITY_NBR,
  SERVICE_GROUP_CHANGED_IND,
  RATE
FROM w
WHERE RATE = grp_max_rate      -- at the max
  AND cnt_at_rate >= 2;        -- with 2+ rows tied at that max
