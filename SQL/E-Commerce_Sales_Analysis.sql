-- =========================================================
-- E-COMMERCE SALES ANALYSIS
-- Tools: MySQL
-- Dataset: E-Commerce Sales Data
-- =========================================================

-- 1. Select Database
USE ecommerce_sales;


-- =========================================================
-- 2. BASIC DATA CHECKS
-- =========================================================

-- Check number of records
SELECT COUNT(*) AS Total_Records
FROM ecommerce_data;

-- View sample data
SELECT *
FROM ecommerce_data
LIMIT 10;


-- =========================================================
-- 3. DATA CLEANING
-- =========================================================

-- Remove unwanted spaces from Customer Segment
UPDATE ecommerce_data
SET Customer_Segment = TRIM(Customer_Segment);

-- Convert discount values stored as whole percentages
-- Example: 5 becomes 0.05
UPDATE ecommerce_data
SET Discount = Discount / 100
WHERE Discount >= 1;


-- =========================================================
-- 4. DATA QUALITY CHECK
-- =========================================================

SELECT
    SUM(Order_ID IS NULL) AS Missing_Order_ID,
    SUM(Order_Date IS NULL) AS Missing_Order_Date,
    SUM(Product IS NULL) AS Missing_Product,
    SUM(Category IS NULL) AS Missing_Category,
    SUM(Sales IS NULL) AS Missing_Sales,
    SUM(Profit IS NULL) AS Missing_Profit
FROM ecommerce_data;


-- =========================================================
-- 5. KEY PERFORMANCE INDICATORS (KPIs)
-- =========================================================

-- Total Sales
SELECT SUM(Sales) AS Total_Sales
FROM ecommerce_data;

-- Total Profit
SELECT SUM(Profit) AS Total_Profit
FROM ecommerce_data;

-- Total Quantity
SELECT SUM(Quantity) AS Total_Quantity
FROM ecommerce_data;

-- Total Orders
SELECT COUNT(*) AS Total_Orders
FROM ecommerce_data;

-- Average Sales / Average Order Value
SELECT AVG(Sales) AS Average_Order_Value
FROM ecommerce_data;

-- Profit Margin
SELECT
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Percentage
FROM ecommerce_data;


-- =========================================================
-- 6. SALES BY CATEGORY
-- =========================================================

SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY Category
ORDER BY Total_Sales DESC;


-- =========================================================
-- 7. PROFIT BY CATEGORY
-- =========================================================

SELECT
    Category,
    SUM(Profit) AS Total_Profit
FROM ecommerce_data
GROUP BY Category
ORDER BY Total_Profit DESC;


-- =========================================================
-- 8. SALES BY CUSTOMER SEGMENT
-- =========================================================

SELECT
    Customer_Segment,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY Customer_Segment
ORDER BY Total_Sales DESC;


-- =========================================================
-- 9. PROFIT BY CUSTOMER SEGMENT
-- =========================================================

SELECT
    Customer_Segment,
    SUM(Profit) AS Total_Profit
FROM ecommerce_data
GROUP BY Customer_Segment
ORDER BY Total_Profit DESC;


-- =========================================================
-- 10. SALES BY STATE
-- =========================================================

SELECT
    State,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY State
ORDER BY Total_Sales DESC;


-- =========================================================
-- 11. SALES BY PAYMENT METHOD
-- =========================================================

SELECT
    Payment_Method,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;


-- =========================================================
-- 12. ORDERS BY ORDER STATUS
-- =========================================================

SELECT
    Order_Status,
    COUNT(*) AS Order_Count
FROM ecommerce_data
GROUP BY Order_Status
ORDER BY Order_Count DESC;


-- =========================================================
-- 13. MONTHLY SALES TREND
-- =========================================================

SELECT
    MONTHNAME(Order_Date) AS Month,
    MONTH(Order_Date) AS Month_Number,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY Month_Number;


-- =========================================================
-- 14. TOP 10 PRODUCTS BY SALES
-- =========================================================

SELECT
    Product,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;


-- =========================================================
-- 15. TOP 10 PRODUCTS BY PROFIT
-- =========================================================

SELECT
    Product,
    SUM(Profit) AS Total_Profit
FROM ecommerce_data
GROUP BY Product
ORDER BY Total_Profit DESC
LIMIT 10;


-- =========================================================
-- 16. TOP 10 CUSTOMERS BY SALES
-- =========================================================

SELECT
    Customer_ID,
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;


-- =========================================================
-- 17. SALES AND PROFIT BY DISCOUNT
-- =========================================================

SELECT
    Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM ecommerce_data
GROUP BY Discount
ORDER BY Discount;


-- =========================================================
-- 18. SALES BY CITY
-- =========================================================

SELECT
    City,
    SUM(Sales) AS Total_Sales
FROM ecommerce_data
GROUP BY City
ORDER BY Total_Sales DESC;


-- =========================================================
-- 19. OVERALL SALES AND PROFIT
-- =========================================================

SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Sales), 2) AS Average_Order_Value
FROM ecommerce_data;
