## 1. Local Environment Setup
1. Open **SQL Server Management Studio (SSMS)**.
2. Connect to the server using **Windows Authentication**.
3. Run the script `sql/01_database_setup.sql` to create the `staging`, `warehouse`, and `ops` schemas.

## 2. Daily Health Check (The "Morning Routine")
Your first task every morning is to check the ETL logs:
```sql
SELECT TOP 20 * 
FROM ops.etl_run_log 
ORDER BY start_time DESC;
Use code with caution.

If status is SUCCESS: Check ops.data_quality_issues for any 'MEDIUM' warnings.
If status is FAILED: Copy the error_message and follow the Escalation Playbook.
3. Handling Ad-hoc Requests
Stakeholders frequently ask for "Return Rates." Use the pre-built procedure:
sql
EXEC ops.sp_get_location_performance;
Use code with caution.

If they ask for a specific location not in the report, escalate to the BI Data Ops Engineer.

### 3. `data_dictionary.md`
This demonstrates your "attention to detail" and helps technical and business teams speak the same language.

```markdown
# Data Dictionary: Warehouse Schema

## Table: `warehouse.orders`
The primary source of truth for all validated sales transactions.


| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `order_key` | INT (PK) | Internal surrogate key for the Data Warehouse. |
| `order_id` | INT | The original ID from the source Mobile App. |
| `customer_id` | INT | Unique identifier for the customer (must not be NULL). |
| `order_date` | DATETIME | The timestamp when the order was placed. |
| `amount` | DECIMAL | Total order value in KES (Negative values are filtered out). |
| `location` | VARCHAR | Neighborhood/Region (e.g., Karen, Westlands, CBD). |
| `dw_load_date`| DATETIME | Timestamp of when this record was moved to the Warehouse. |

## Table: `ops.data_quality_rules`
Defines the "Quality Gates" used to protect the Warehouse.

*   **Rule 101:** Rejects orders with an `amount < 0`.
*   **Rule 104:** Flags "Extreme Outliers" (Orders > KES 500k) for manual audit.