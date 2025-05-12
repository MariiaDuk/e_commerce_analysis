--  Підготовка таблиці для створення когортного аналізу у Tableau

WITH cte AS (
  SELECT *
    , MIN(FORMAT_DATE('%Y-%m', TransactionDate)) OVER(PARTITION BY CustomerNo) AS FirstOrderDate
  FROM `my-pet-project-458715.Sales_Transaction.sales_transaction_cleaned`
  WHERE Quantity > 0
)
SELECT 
  FORMAT_DATE('%Y-%m', TransactionDate) AS TransactionDate,
  COUNT(DISTINCT CustomerNo) AS Customers,
  FirstOrderDate
FROM cte
WHERE FORMAT_DATE('%Y-%m', TransactionDate) != '2019-12'
GROUP BY 
  FORMAT_DATE('%Y-%m', TransactionDate),
  FirstOrderDate;
