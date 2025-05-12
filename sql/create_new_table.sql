-- Створюємо нову таблицю без дублікатів

CREATE OR REPLACE TABLE sales_clean AS
SELECT DISTINCT *
FROM sales;

-- Перевіряємо, чи отримали очікувану кількість рядків після очищення даних від дублікатів рядків (так, рядків 531150, як і очікувалось)

SELECT COUNT(*)
FROM sales_clean;
