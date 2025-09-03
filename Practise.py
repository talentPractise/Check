-- Adjust project.dataset names below
WITH rates AS (
  SELECT
    r.*,
    ph.score
  FROM project.dataset.CET_RATES r
  JOIN project.dataset.PAYMENT_METHOD_HIERARCHY ph
    ON ph.payment_method_cd = r.payment_method_cd
)
SELECT
  *
FROM rates
QUALIFY
  -- 1) Multiple payment methods present in the group
  COUNT(DISTINCT payment_method_cd) OVER (
    PARTITION BY service_cd, product_cd, contract_type, service_type_cd, place_of_service_cd
  ) > 1
  AND
  -- 2) All payment methods in that group have the SAME score
  COUNT(DISTINCT score) OVER (
    PARTITION BY service_cd, product_cd, contract_type, service_type_cd, place_of_service_cd
  ) = 1
-- Optional cap while exploring
LIMIT 500;
