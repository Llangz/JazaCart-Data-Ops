-- Create Schemas
CREATE SCHEMA staging;
GO
CREATE SCHEMA warehouse;
GO
CREATE SCHEMA ops;
GO

-- Create Tables
CREATE TABLE ops.etl_run_log (
    run_id INT IDENTITY(1,1) PRIMARY KEY,
    process_name VARCHAR(100),
    start_time DATETIME DEFAULT GETDATE(),
    end_time DATETIME NULL,
    status VARCHAR(20),
    rows_processed INT DEFAULT 0,
    error_message NVARCHAR(MAX) NULL
);

CREATE TABLE ops.data_quality_rules (
    rule_id INT PRIMARY KEY,
    rule_name VARCHAR(100),
    severity VARCHAR(10)
);

CREATE TABLE ops.data_quality_issues (
    issue_id INT IDENTITY(1,1) PRIMARY KEY,
    rule_id INT REFERENCES ops.data_quality_rules(rule_id),
    table_name VARCHAR(50),
    affected_record_id VARCHAR(50),
    detected_at DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'OPEN'
);

CREATE TABLE staging.orders (
    order_id INT,
    customer_id INT NULL,
    order_date DATETIME,
    amount DECIMAL(18,2),
    location VARCHAR(50)
);

CREATE TABLE warehouse.orders (
    order_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    customer_id INT,
    order_date DATETIME,
    amount DECIMAL(18,2),
    location VARCHAR(50),
    dw_load_date DATETIME DEFAULT GETDATE()
);

-- Seed DQ Rules
INSERT INTO ops.data_quality_rules VALUES 
(101, 'Negative Price', 'HIGH'),
(102, 'Orphan/Duplicate', 'MEDIUM'),
(103, 'Future Date', 'HIGH'),
(104, 'Extreme Outlier', 'HIGH');
