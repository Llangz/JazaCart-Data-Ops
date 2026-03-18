# Root Cause Analysis (RCA): Duplicate Order & Revenue Inflation
**Date:** 2024-05-20  
**Status:** Resolved  
**Issue ID:** DQ-102 (Duplicates)

## 1. Executive Summary
Between May 1st and May 15th, the BI Dashboard showed a 15% unexplained spike in revenue. Investigation revealed that Order ID `101` and several others were appearing twice in the `staging.orders` table, leading to double-counting in the Warehouse.

## 2. Investigation Findings
*   **Symptom:** `SELECT order_id, COUNT(*) FROM staging.orders GROUP BY order_id HAVING COUNT(*) > 1` returned multiple records.
*   **Technical Root Cause:** The mobile app's "Order Now" button lacked an "idempotency key." If a customer in a low-network area (e.g., transit on Mombasa Road) clicked the button twice during a lag, the API processed two identical records with the same Order ID.
*   **Data Impact:** 4% of total monthly records were affected, inflating the 'Gross Sales' KPI.

## 3. Resolution & Prevention
*   **Immediate Fix:** Updated the Warehouse Load script to use `SELECT DISTINCT` to deduplicate records during the ETL process.
*   **Long-term Fix:** Logged a ticket with the Backend Engineering team to implement "request-signing" on the mobile API to reject duplicate IDs at the source.
*   **Monitoring:** Added Rule 102 to the `ops.data_quality_rules` table to flag any future occurrences in the daily Ops report.
