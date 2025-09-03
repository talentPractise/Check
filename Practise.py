WITH joined AS (
  SELECT r.*, p.score
  FROM CET_RATES r
  JOIN PAYMENT_METHOD_HIERARCHY p
    ON r.PAYMENT_METHOD_CD = p.PAYMENT_METHOD_CD
),
maxed AS (
  SELECT
    joined.*,
    MAX(rate) OVER (
      PARTITION BY service_cd, service_type_cd, place_of_service_cd, payment_method_cd
    ) AS max_rate_in_group
  FROM joined
),
winners AS (
  -- keep only rows at the max(rate) within each (svc, type, pos, payment)
  SELECT *
  FROM maxed
  WHERE rate = max_rate_in_group
)
SELECT
  service_cd,
  service_type_cd,
  place_of_service_cd,
  payment_method_cd,
  ARRAY_AGG(DISTINCT service_group_changed_ind) AS group_indicators,
  ARRAY_AGG(DISTINCT score) AS scores_present,
  COUNT(*) AS rows_at_max
FROM winners
GROUP BY
  service_cd, service_type_cd, place_of_service_cd, payment_method_cd
HAVING
  CARDINALITY(ARRAY_AGG(DISTINCT service_group_changed_ind)) = 2   -- e.g., Y and N
  AND CARDINALITY(ARRAY_AGG(DISTINCT score)) >= 2                   -- different scores present
LIMIT 10;
