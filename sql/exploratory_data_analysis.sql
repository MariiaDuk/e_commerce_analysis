-- Дивимось, що є в таблиці та як це виглядає
SELECT *
FROM sales
LIMIT 1000;


-- Рахуємо загальну кількість рядків (536350) та кількість пустих значень по кожному стовпцю (відсутні)
SELECT COUNT(*)
 , COUNT(*) - COUNT(TransactionNo)
 , COUNT(*) - COUNT(TransactionDate)
 , COUNT(*) - COUNT(ProductNo)
 , COUNT(*) - COUNT(ProductName)
 , COUNT(*) - COUNT(Price)
 , COUNT(*) - COUNT(Quantity)
 , COUNT(*) - COUNT(CustomerNo)
 , COUNT(*) - COUNT(Country)
FROM sales;


-- Рахуємо кількість null значень по кожному стовпцю (відсутні)
SELECT COUNTIF(TransactionNo IS NULL)
 , COUNTIF(TransactionDate IS NULL)
 , COUNTIF(ProductNo IS NULL)
 , COUNTIF(ProductName IS NULL)
 , COUNTIF(Price IS NULL)
 , COUNTIF(Quantity IS NULL)
 , COUNTIF(CustomerNo IS NULL)
 , COUNTIF(Country IS NULL)
FROM sales;


-- В описі датасета сказано, що у рядків з поверненнями TransactionNo починається з 'С', а Quantity має відʼємне значення. Перевіримо, чи є рядки, де кількість товару відʼємна, а номер транзакції не починається з 'С' (ні)
SELECT *
FROM sales
WHERE Quantity < 0 AND LEFT(TransactionNo, 1) != 'C';


-- Перевіримо, чи є рядки, де кількість товару додатна, а номер транзакції починається з 'С' (ні)
SELECT *
FROM sales
WHERE Quantity > 0 AND LEFT(TransactionNo, 1) = 'C';


-- Також перевіримо, чи є рядки, де кількість товару або вартість дорівнюють 0 (ні)
SELECT *
FROM sales
WHERE Quantity = 0 OR Price = 0;


-- Перевіряємо, чи є в таблиці дублікати (так, бачимо 4794 рядки, кожен з яких є в таблиці більше, ніж 1 раз)
SELECT *, COUNT(*) AS cnt_rows
FROM sales
GROUP BY TransactionNo, TransactionDate, ProductNo, ProductName, Price, Quantity, CustomerNo, Country
HAVING COUNT(*) > 1;


-- Ми будемо видаляти дублікати та зберігати результат як нову таблицю, з якою далі будемо працювати в табло. Щоб потім впевнитися, що цей етап пройшов нормально, порахуємо кількість унікальних рядків (526356) та додамо кількість рядків, які дублюються 526356+4794=531150. Тобто у новій таблиці ми маємо отримати 531150 рядків
SELECT *, COUNT(*) AS cnt_rows
FROM sales
GROUP BY TransactionNo, TransactionDate, ProductNo, ProductName, Price, Quantity, CustomerNo, Country
HAVING COUNT(*) = 1;
