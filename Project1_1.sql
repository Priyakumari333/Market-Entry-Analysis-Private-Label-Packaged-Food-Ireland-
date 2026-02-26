USE project1;
create table product(
product_id varchar(20),
product_name varchar(50),
category varchar(50)
);

INSERT INTO product(product_id, product_name, category) VALUES
(101, 'Biscuits', 'Snacks'),
(102, 'Potato Chips', 'Snacks')
(103, 'Label Noodles', 'Ready to Eat'),
(104, 'Private Label Pasta', 'Staples'),
(105,	'Private Label Cornflakes',	'Breakfast');

SELECT * FROM product;

USE project1;

CREATE TABLE cost_structure (
    Product_ID         INT PRIMARY KEY,
    Raw_Material_Cost  DECIMAL(5,2),
    Packaging_Cost     DECIMAL(5,2),
    Logistics_Cost     DECIMAL(5,2),
    Fixed_Cost_Allocated DECIMAL(5,2),
    Total_Cost         DECIMAL(5,2)
);

USE project1;

CREATE TABLE cost_structure (
    Product_ID         INT PRIMARY KEY,
    Raw_Material_Cost  DECIMAL(5,2),
    Packaging_Cost     DECIMAL(5,2),
    Logistics_Cost     DECIMAL(5,2),
    Fixed_Cost_Allocated DECIMAL(5,2),
    Total_Cost         DECIMAL(5,2)
);

INSERT INTO cost_structure (
    Product_ID,
    Raw_Material_Cost,
    Packaging_Cost,
    Logistics_Cost,
    Fixed_Cost_Allocated,
    Total_Cost
) VALUES
(101, 0.45, 0.20, 0.10, 0.15, 0.90),
(102, 0.50, 0.22, 0.12, 0.16, 1.00),
(103, 0.55, 0.25, 0.15, 0.20, 1.15),
(104, 0.60, 0.25, 0.15, 0.20, 1.20),
(105, 0.65, 0.30, 0.18, 0.22, 1.35);

SELECT * FROM cost_structure;

USE project1;

CREATE TABLE pricing (
    Product_ID       INT PRIMARY KEY,
    Competitor_Price DECIMAL(5,2),
    Target_Price     DECIMAL(5,2)
);

INSERT INTO pricing (
    Product_ID,
    Competitor_Price,
    Target_Price
) VALUES
(101, 1.30, 1.25),
(102, 1.50, 1.45),
(103, 1.70, 1.65),
(104, 1.75, 1.70),
(105, 2.10, 2.00);

SELECT * FROM demand;
USE project1;
select * from gross_margin;
CREATE TABLE demand (
    Product_ID      INT,
    Region          VARCHAR(10),
    Monthly_Demand  INT,
    PRIMARY KEY (Product_ID, Region)
);

INSERT INTO demand (
    Product_ID,
    Region,
    Monthly_Demand
) VALUES
(101, 'Urban', 9000),
(101, 'Rural', 4000),

(102, 'Urban', 8000),
(102, 'Rural', 3500),

(103, 'Urban', 6000),
(103, 'Rural', 2500),

(104, 'Urban', 5500),
(104, 'Rural', 2200),

(105, 'Urban', 6500),
(105, 'Rural', 3000);

use project1;


CREATE TABLE final_recommendation (
    Product_ID      INT,
    Product_Name          VARCHAR(50),
    Monthly_Demand  INT,
    Margin_Status VARCHAR(50),
    Launch_Decision VARCHAR(50),
    Launch_Price float,
    PRIMARY KEY (Product_ID)
);

INSERT INTO final_recommendation (
    Product_ID      ,
    Product_Name     ,
    Monthly_Demand  ,
    Margin_Status ,
    Launch_Decision ,
    Launch_Price
) VALUES
(101, 'Biscuits', 13000,'Below Target', 'Review Cost', 1.25),
(102, 'Potato Chips', 11500,'Above Target', 'Launch', 1.45),
(103, 'Label Noodles', 8500,'Above Target', 'Launch', 1.65),
(104, 'Private Label Pasta', 7700,'Below Target', 'Review Cost', 1.70),
(105, 'Private Label Cornflakes', 9500,'Above Target', 'Launch', 2.00);

drop table final_recommendation;
use project1;