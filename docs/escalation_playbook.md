This document outlines the standard procedures for identifying, investigating, and resolving data quality and ETL issues within the JazaCart ecosystem. 

1. Incident Classification
Every issue detected by the ops.sp_run_etl_pipeline or the ops.data_quality_issues log must be classified to determine the response urgency. 

Severity 	Description	Action
CRITICAL	ETL Failure (status = 'FAILED') or High-Severity Rule violation (e.g., Outliers > KES 1M).	Immediate investigation; stop downstream BI updates.
MAJOR	Multiple OPEN issues in ops.data_quality_issues (e.g., >10% of daily rows).	Resolve within 4 hours; notify stakeholders of potential data lag.
MINOR	Isolated data entry errors (e.g., single null customer_id).	Log for weekly cleanup; do not interrupt pipeline.
2. Tiered Escalation Matrix
The following path ensures issues are handled by the right level of expertise. 
Level 	Primary Contact	Responsibilities
L1: Data Support	Junior Data Engineer	Monitor ops.etl_run_log. Restart failed jobs. Handle known "MINOR" data entry fixes.
L2: Data Ops	BI Data Ops Engineer (You)	Perform Root Cause Analysis (RCA). Handle "MAJOR" and "CRITICAL" logic failures. Adjust ETL SQL scripts.
L3: BI Dev	Senior BI / Data Architect	Fix structural schema changes or complex upstream API integration bugs.
3. Step-by-Step Response Flow
When an alert is triggered (e.g., an ETL failure in your log table), follow this sequence: 

Identify: Query ops.etl_run_log to find the exact error_message.
Investigate: Run the Audit Query to see which specific records in staging.orders triggered the ops.data_quality_issues.
Contain: If the error is critical, disable the scheduled Power BI refresh to prevent "Garbage In, Garbage Out".
Resolve:
Data Issue: Correct the staging record or update the validation rule.
Logic Issue: Update the Stored Procedure ops.sp_run_etl_pipeline.
Document: Update the RCA_LOG.md with the cause and permanent fix. 

4. Communication Standards
Internal (Slack/Teams): Notify the #data-alerts channel for any CRITICAL failure.
Stakeholders: If data will be delayed by >2 hours, send an update to the Sales/Finance teams.