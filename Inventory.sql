
-- a) Total profit per product category
SELECT 
    p.Product_Category,
    SUM((p.Product_Price - p.Product_Cost) * s.Units_Sold) AS Total_Profit
FROM Sales s
JOIN Products p ON s.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY Total_Profit DESC;

-- b) Products with highest margin (%)
SELECT 
    p.Product_Name,
    ROUND(((p.Product_Price - p.Product_Cost) / p.Product_Price) * 100, 2) AS Margin_Percentage
FROM Products p
ORDER BY Margin_Percentage DESC
LIMIT 10;

-- c) Stores with highest revenue
SELECT 
    st.Store_Name,
    SUM(s.Units_Sold * p.Product_Price) AS Total_Revenue
FROM Sales s
JOIN Stores st ON s.Store_ID = st.Store_ID
JOIN Products p ON s.Product_ID = p.Product_ID
GROUP BY st.Store_Name
ORDER BY Total_Revenue DESC;



-- a) Cities with most units sold
SELECT 
    st.Store_City,
    SUM(s.Units_Sold) AS Total_Units_Sold
FROM Sales s
JOIN Stores st ON s.Store_ID = st.Store_ID
GROUP BY st.Store_City
ORDER BY Total_Units_Sold DESC;

-- b) Underperforming stores (lowest revenue)
SELECT 
    st.Store_Name,
    SUM(s.Units_Sold * p.Product_Price) AS Revenue
FROM Sales s
JOIN Stores st ON s.Store_ID = st.Store_ID
JOIN Products p ON s.Product_ID = p.Product_ID
GROUP BY st.Store_Name
ORDER BY Revenue ASC
LIMIT 5;



-- a) Monthly sales trend
SELECT 
    DATE_TRUNC('month', s.Date) AS Month,
    SUM(s.Units_Sold) AS Total_Units_Sold,
    SUM(s.Units_Sold * p.Product_Price) AS Total_Revenue
FROM Sales s
JOIN Products p ON s.Product_ID = p.Product_ID
GROUP BY Month
ORDER BY Month;

-- b) Seasonal product spikes
SELECT 
    p.Product_Name,
    DATE_TRUNC('month', s.Date) AS Month,
    SUM(s.Units_Sold) AS Units_Sold
FROM Sales s
JOIN Products p ON s.Product_ID = p.Product_ID
GROUP BY p.Product_Name, Month
ORDER BY Units_Sold DESC;



-- a) Stores with low stock for high-demand products
SELECT 
    i.Store_ID,
    st.Store_Name,
    p.Product_Name,
    i.Stock_On_Hand
FROM Inventory i
JOIN Stores st ON i.Store_ID = st.Store_ID
JOIN Products p ON i.Product_ID = p.Product_ID
WHERE i.Stock_On_Hand < 10
ORDER BY i.Stock_On_Hand ASC;

-- b) Total inventory value per store
SELECT 
    st.Store_Name,
    SUM(i.Stock_On_Hand * p.Product_Cost) AS Inventory_Value
FROM Inventory i
JOIN Stores st ON i.Store_ID = st.Store_ID
JOIN Products p ON i.Product_ID = p.Product_ID
GROUP BY st.Store_Name
ORDER BY Inventory_Value DESC;

-- c) Products needing urgent restocking
SELECT 
    p.Product_Name,
    SUM(i.Stock_On_Hand) AS Total_Stock
FROM Inventory i
JOIN Products p ON i.Product_ID = p.Product_ID
GROUP BY p.Product_Name
HAVING SUM(i.Stock_On_Hand) < 20
ORDER BY Total_Stock ASC;
