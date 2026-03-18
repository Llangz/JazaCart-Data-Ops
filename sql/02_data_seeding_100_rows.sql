INSERT INTO staging.orders (order_id, customer_id, order_date, amount, location)
VALUES 
(101, 30, '2024-03-10', 10369.4, 'Mombasa Road'), (102, 28, '2024-03-24', 14544.74, 'Mombasa Road'),
(103, 22, '2024-03-15', 10193.15, 'Westlands'), (104, 33, '2024-01-14', 8182.72, 'Karen'),
(105, 10, '2024-05-18', 9352.84, 'CBD'), (106, 50, '2030-12-25', 2253.89, 'Lavington'), -- FUTURE
(112, 20, '2024-01-02', 999999.0, 'Parklands'), -- OUTLIER
(113, 19, '2024-05-26', 999999.0, 'Westlands'), -- OUTLIER
(114, 25, '2024-04-13', 12711.99, 'CBD'), (114, 25, '2024-04-13', 12711.99, 'CBD'), -- DUP
(124, NULL, '2024-05-18', 11986.32, 'Karen'), -- NULL
(150, 48, '2024-01-18', -12975.24, 'Lavington'), -- NEGATIVE
(184, 18, '2030-12-25', 14210.0, 'Westlands'), -- FUTURE
-- ... [Include all other rows from our previous 100-row prompt here] ...
(200, 42, '2024-03-31', 11628.21, 'Mombasa Road');
