-- Перевіряємо успішні та скасовані транзакції з найбільшою кількістю товару. Бачимо, що два успішно сплачених замовлення (TransactionNo = 581483 та 541431) одразу після цього були створені ще раз та відмінені (581483/C581484 та 541431/C541433, відмінені айдішки більш пізні).
SELECT *
FROM (
  SELECT *
  FROM sales_clean
  ORDER BY Quantity DESC
  LIMIT 3
)
UNION ALL
SELECT *
FROM (
  SELECT *
  FROM sales_clean
  ORDER BY Quantity
  LIMIT 3
);


-- Подивимось всі замовлення цих клієнтів.
SELECT *
FROM sales_clean
WHERE CustomerNo = '16446' OR CustomerNo = '12346'
ORDER BY CustomerNo, TransactionNo;
