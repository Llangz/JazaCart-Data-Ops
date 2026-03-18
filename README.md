# JazaCart Data Ops Health & Reliability System 

###  The Mission
In high-growth e-commerce, bad data costs money. This project simulates a **Production Data Operations** environment for "JazaCart," a Nairobi-based retailer. I built this to solve critical business problems—such as "ghost orders" and financial outliers—that skew executive dashboards and erode trust in BI.

###  Why This Project Matters
Most BI projects focus only on "pretty charts." This project focuses on **Data Reliability**. I’ve bridged the gap between First-Level Support and BI Development by implementing a "Quality Gate" architecture. This system catches duplicates, nulls, and outliers before they hit the data warehouse, ensuring stakeholders make decisions based on 100% accurate data.

---

###  Tech Stack & Concepts
*   **Database Engine:** Microsoft SQL Server (T-SQL)
*   **Architecture:** Staging-to-Warehouse (Star Schema) with a dedicated **Monitoring (Ops) Layer**.
*   **Advanced SQL:** CTEs, Window Functions, Stored Procedures, and Dynamic Outlier Detection.
*   **Process:** Automated ETL Logging, Root Cause Analysis (RCA), and Junior Mentorship Framework.

###  Key Operational Features
*   **Observability Layer:** A custom `ops` schema acting as a "Black Box" recorder for every ETL run, logging timestamps, row counts, and error messages.
*   **Automated Quality Gates:** A rules-based engine that automatically flags and quarantines "dirty" data (e.g., KES 999k+ outliers or future-dated orders).
*   **Stakeholder Analytics:** Stored procedures to handle ad-hoc business requests, such as "Return Rates for Karen vs. Westlands."
*   **Mentorship Ready:** Includes an escalation playbook and onboarding guide designed to upskill Junior Data Engineers.

---

###  Project Structure & How to Explore
*   [**`/sql`**](sql/): Contains the Schema definitions, ETL logic, and Audit scripts.
*   [**`/docs`**](docs/): View the **Root Cause Analysis (RCA)** on duplicate orders and the **Onboarding Guide**.

---

###  Data Operations Escalation Playbook
This section outlines the standard procedures for resolving data quality issues within the JazaCart ecosystem.

#### 1. Incident Classification


| Severity | Description | Action |
| :--- | :--- | :--- |
| **CRITICAL** | ETL Failure or High-Severity Rule violation (e.g., Outliers > KES 1M). | Immediate investigation; stop downstream BI updates. |
| **MAJOR** | Multiple `OPEN` issues in DQ log (>10% of daily rows). | Resolve within 4 hours; notify stakeholders of potential lag. |
| **MINOR** | Isolated data entry errors (e.g., single null `customer_id`). | Log for weekly cleanup; do not interrupt pipeline. |

#### 2. Tiered Escalation Matrix


| Level | Primary Contact | Responsibilities |
| :--- | :--- | :--- |
| **L1: Support** | Junior Data Engineer | Monitor logs, restart failed jobs, handle "MINOR" fixes. |
| **L2: Data Ops** | **BI Data Ops Engineer (You)** | Perform **RCA**, handle "MAJOR/CRITICAL" logic failures. |
| **L3: BI Dev** | Senior BI Architect | Fix structural schema changes or complex upstream API bugs. |

#### 3. Response Flow & Standards
1.  **Identify:** Query `ops.etl_run_log` for the exact error message.
2.  **Investigate:** Run the Audit Query to isolate specific records in `staging.orders`.
3.  **Contain:** If critical, disable Power BI refreshes to prevent "Garbage In, Garbage Out."
4.  **Resolve:** Correct the record or update the validation rule in the stored procedure.
5.  **Communicate:** Notify `#data-alerts` on Slack/Teams; update stakeholders if delay > 2 hours.

---

> **Personal Note:** I built this project to demonstrate that I don't just move data—I ensure its **accuracy and reliability**. I’ve implemented a framework that proactively catches issues before they ever reach a business dashboard.
