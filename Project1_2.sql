Use project1;
SELECT Region,
SUM(Monthly_Demand) AS Total_Monthly_Demand
From Demand
Group By Region;

-- Hypothesis 2

CREATE table gross_margin AS
SELECT 
    c.Product_ID,
    p.Target_Price,
    c.Total_Cost,
    ROUND( (p.Target_Price - c.Total_Cost) / p.Target_Price * 100, 2 ) AS Gross_Margin_Percent
FROM cost_structure c
JOIN pricing p ON c.Product_ID = p.Product_ID;

SELECT * FROM gross_margin ORDER BY Product_ID;

-- Hypothesis 3


DROP TABLE IF EXISTS profit_analysis1;

CREATE TABLE profit_analysis (
    product_id INT PRIMARY KEY,
    selling_price DECIMAL(6,2),
    cost_price DECIMAL(6,2),
    logistics_cost DECIMAL(6,2)
) ENGINE=InnoDB;

INSERT INTO profit_analysis 
SELECT 
    c.Product_ID,
    p.Target_Price AS selling_price,  -- Change to AVG(p.Urban_Price, p.SemiUrban_Price, p.Rural_Price) if preferred
    c.Total_Cost AS cost_price,
    c.Logistics_Cost
FROM cost_structure c
JOIN pricing p ON c.Product_ID = p.Product_ID;
select * from profit_analysis;

SELECT 
    pa.product_id,
    pa.selling_price,
    pa.cost_price,
    pa.logistics_cost,
    ROUND((pa.logistics_cost / pa.selling_price) * 100, 2) AS logistics_cost_pct,
    ROUND(((pa.selling_price - pa.cost_price - pa.logistics_cost) / pa.selling_price) * 100, 2) AS net_profit_margin
FROM profit_analysis pa
ORDER BY pa.product_id;

SELECT 
    product_id,
    ROUND(AVG(selling_price),2) AS avg_selling_price,
    ROUND(AVG(logistics_cost/selling_price*100),2) AS avg_logistics_pct,
    ROUND(AVG((selling_price-cost_price-logistics_cost)/selling_price*100),2) AS avg_net_margin
FROM profit_analysis 
GROUP BY product_id;  -- Same result as detail since 1 row/product

select * from profit_analysis;
 
 -- other
 -- Switch DB
USE project1;

-- Drop if exists
IF OBJECT_ID('gross_margin', 'U') IS NOT NULL DROP TABLE gross_margin;

-- Create table
SELECT 
    c.Product_ID,
    p.Target_Price,
    c.Total_Cost,
    ROUND( (p.Target_Price - c.Total_Cost) / p.Target_Price * 100, 2 ) AS Gross_Margin_Percent
INTO gross_margin
FROM cost_structure c
JOIN pricing p ON c.Product_ID = p.Product_ID;

-- View results
SELECT * FROM gross_margin ORDER BY Product_ID;


USE project1;
SELECT * FROM sys.tables WHERE name = 'gross_margin';  -- Confirms existence
SELECT COUNT(*) AS row_count FROM gross_margin;        -- Should show joined rows
SELECT * FROM gross_margin ORDER BY Product_ID;  
select * from profit_analysis;      -- Full preview



CREATE TABLE product_profit_summary AS
SELECT 
    product_id,
    ROUND(AVG(selling_price), 2) AS avg_selling_price,
    ROUND(AVG(logistics_cost / selling_price * 100), 2) AS avg_logistics_pct,
    ROUND(AVG((selling_price - cost_price - logistics_cost) / selling_price * 100), 2) AS avg_net_margin
FROM profit_analysis
GROUP BY product_id;
select * from product_profit_summary;

CREATE TABLE product_profit_summary1 (
    product_id CHAR(10) NOT NULL,
    avg_selling_price DECIMAL(10,2),
    avg_logistics_pct DECIMAL(5,2),
    avg_net_margin DECIMAL(5,2),
    PRIMARY KEY (product_id)
);

INSERT INTO product_profit_summary1
SELECT 
    product_id,
    ROUND(AVG(selling_price), 2),
    ROUND(AVG(logistics_cost / NULLIF(selling_price, 0) * 100), 2),
    ROUND(AVG((selling_price - cost_price - logistics_cost) / NULLIF(selling_price, 0) * 100), 2)
FROM profit_analysis
GROUP BY product_id;
select * from product_profit_summary1;


















