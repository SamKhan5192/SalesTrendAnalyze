select * from OnlineSales

--******************************************************************
-- Changing column name to date to order_date
exec sp_rename 'onlinesales.Date','Order_Date','column'

--******************************************************************

select Order_Date, DATEPART(month,Order_Date) as Month from OnlineSales

--******************************************************************

create view Sales_data
as
select *, datepart(month,Order_Date) as Month from OnlineSales

SELECT 
	YEAR(ORDER_DATE) AS YEAR,
	MONTH(ORDER_DATE) AS MONTH,
	SUM(TOTAL_REVENUE) AS REVENUE,
	COUNT(DISTINCT TRANSACTION_ID) AS ORDER_COUNT
FROM 
	OnlineSales
WHERE
	Order_Date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
	YEAR(ORDER_DATE), MONTH(ORDER_DATE)
ORDER BY 
	YEAR, MONTH
	
--******************************************************************
SELECT 
	YEAR(ORDER_DATE) AS YEAR,
	MONTH(ORDER_DATE) AS MONTH,
	SUM(TOTAL_REVENUE) AS REVENUE,
	COUNT(DISTINCT TRANSACTION_ID) AS ORDER_COUNT
INTO Monthly_Sales_Summary
FROM 
	OnlineSales
WHERE
	Order_Date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
	YEAR(ORDER_DATE), MONTH(ORDER_DATE)
ORDER BY 
	YEAR, MONTH

--******************************************************************

select * from Monthly_Sales_Summary