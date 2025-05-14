-- Середня кількість товарів у чеку по клієнтах, які беруть до 10 одиниць товарів одного типу за раз

SELECT ROUND(AVG(QuantityInOrder)) AS AvgQuantityInOrder
FROM (
  SELECT TransactionNo, SUM(Quantity) AS QuantityInOrder
  FROM `my-pet-project-458715.Sales_Transaction.sales_transaction_cleaned`
  WHERE CustomerNo IN ( 
    SELECT CustomerNo
    FROM `my-pet-project-458715.Sales_Transaction.sales_transaction_cleaned`
    WHERE Quantity<=10
    GROUP BY CustomerNo
  )
  GROUP BY TransactionNo
);
