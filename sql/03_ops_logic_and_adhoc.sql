-- 1. Run Data Quality Audit
INSERT INTO ops.data_quality_issues (rule_id, table_name, affected_record_id, status)
SELECT 101, 'staging.orders', order_id, 'OPEN' FROM staging.orders WHERE amount < 0
UNION ALL
SELECT 102, 'staging.orders', order_id, 'OPEN' FROM staging.orders WHERE customer_id IS NULL
UNION ALL
SELECT 103, 'staging.orders', order_id, 'OPEN' FROM staging.orders WHERE order_date > GETDATE()
UNION ALL
SELECT 104, 'staging.orders', order_id, 'OPEN' FROM staging.orders WHERE amount > 500000;

-- 2. Final Clean Load to Warehouse
INSERT INTO warehouse.orders (order_id, customer_id, order_date, amount, location)
SELECT DISTINCT order_id, customer_id, order_date, amount, location
FROM staging.orders
WHERE amount > 0 AND amount < 500000 
  AND customer_id IS NOT NULL 
  AND order_date <= GETDATE();

-- 3. Ad-hoc Stakeholder Query
CREATE PROCEDURE ops.sp_get_location_performance
AS
BEGIN
    SELECT location, COUNT(*) as vol, SUM(amount) as rev 
    FROM warehouse.orders GROUP BY location;
END;
