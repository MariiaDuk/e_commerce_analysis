# E-Commerce Analysis (Pet Project)

Hello! Welcome to my first data analysis pet project. I'd be glad for your attention and feedback.

Goal of this project is to find growth opportunities for an online retail store. This includes finding problem points, points for potential growth and optimization of work.

I used SQL (BigQuery) and Tableau for analysis. For this pet project, I utilized fundamental SQL queries. However, I possess the skills to write more complex queries involving JOINS, UNIONS, window functions, common table expressions, subqueries, etc.

### Data Source

Data Source: [Kaggle](https://www.kaggle.com/datasets/gabrielramos87/an-online-shop-business/data)
Files: [sales.csv](https://github.com/MariiaDuk/e_commerce_analysis/blob/main/data/sales.csv)

> * **Description from original dataset**
> 
> This is a sales transaction data set of UK-based e-commerce (online retail) for one year. This London-based shop has been selling gifts and homewares for adults and children through the website since 2007. Their customers come from all over the world and usually make direct purchases for themselves. There are also small businesses that buy in bulk and sell to other customers through retail outlet channels.
> 
> The data set contains 500K rows and 8 columns. The following is the description of each column.
> 
> 1. TransactionNo (categorical): a six-digit unique number that defines each transaction. The letter “C” in the code indicates a cancellation.
> 2. Date (numeric): the date when each transaction was generated.
> 3. ProductNo (categorical): a five or six-digit unique character used to identify a specific product.
> 4. Product (categorical): product/item name.
> 5. Price (numeric): the price of each product per unit in pound sterling (£).
> 6. Quantity (numeric): the quantity of each product per transaction. Negative values related to cancelled transactions.
> 7. CustomerNo (categorical): a five-digit unique number that defines each customer.
> 8. Country (categorical): name of the country where the customer resides.
> 
> There is a small percentage of order cancellation in the data set. Most of these cancellations were due to out-of-stock conditions on some products. Under this situation, customers tend to cancel an order as they want all products delivered all at once.

### Exploratory data analysis

File: [exploratory_data_analysis.sql](https://github.com/MariiaDuk/e_commerce_analysis/blob/main/sql/exploratory_data_analysis.sql)

**Step 1 — data type checking in BigQuery**

I downloaded csv file with dataset and firstly checked the data types that were automatically defined in BigQuery. All data types were suitable. and made changes for further convenient work.

- TransactionNo — String
- Date — Date
- ProductNo — String
- Product — String
- Price — Float
- Quantity — Integer
- CustomerNo — String
- Country — String

**Step 2 — renaming Date column**

Then I renamed the Date column to TransactionDate, because Date is a reserved word, which could cause errors in queries.

**Step 3 — finding null, empty values and duplicates**

The next step was to check if the table had nulls, empty values, or duplicates. There were no nulls or empty values, but there were duplicates — 4 794 rows were repeated more than once in the table.

In a real project, at this point we would have to contact the business and figure out the reasons for the duplicates. These could be either recorded by mistake, or, for example, products that were purchased in even quantities were somehow split into separate rows. For further work on the project, I assumed these were mistakenly duplicated rows, cleaned the table by removing them, saved a new table `sales_clean.csv` and continued working with it from step 5.

File: [create_table_without_duplicates.sql](https://github.com/MariiaDuk/e_commerce_analysis/blob/main/sql/create_table_without_duplicates.sql)

**Step 4 — checking rows with canceled orders**

The dataset description says that rows with canceled orders have TransactionNo starting with 'C' and Quantity is negative. I checked to see if there are any rows where the quantity of the product is negative and the transaction number does not start with 'C' or vice versa. There were no such rows, the data on canceled orders was unambiguous.

Additionally, I checked whether there were any rows where the quantity of the product or the cost was 0. There were none either.

**Step 5 — data type checking in Tableau**

After exploring the data in SQL, I loaded my new table without duplicates into Tableau, where the first step was to check the data type that Tableau automatically determined. In the Transaction No and CustomerNo columns, I changed the type from Number to String, because it makes no sense to perform computational operations with ID numbers.

- TransactionNo — changed from Number (whole) to String
- TransactionDate — Date
- ProductNo — String
- Product — String
- Price — Number (decimal)
- Quantity — Number (whole)
- CustomerNo — changed from Number (whole) to String
- Country — String

**Step 6 — checking spaces in timeline**

I examined the timeline for any data gaps. The largest such gap is from December 24 to January 3, but we do not consider this an error, because either our business or its clients could not work on New Year's Day.

<img width="1083" alt="Image" src="https://github.com/user-attachments/assets/766cd8fa-364e-4721-9c73-917ef3fbb006" />

At this step, I completed the data quality check phase and started building graphs and looking for insights.

### Analysis in Tableau

You can find dashboards with the analysis results in [Tableau Public](https://public.tableau.com/views/E-CommerceAnalysisPetProject/E-CommerceAnalysis?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

All the values ​​I received in Tableau I also checked in SQL.

One of dashboards includes a cohort retention analysis. For this I made a separate table in SQL, which then processed in Tableau.

File: [table_for_retention_analysis.sql](https://github.com/MariiaDuk/e_commerce_analysis/blob/main/sql/table_for_retention_analysis.sql)

### Main Findings and Recommendations

**Retail and wholesale**

The description of dataset says that it's retail store and "customers usually make direct purchases for themselves". But it is difficult to see this from the data, because customers who take less than 30 units of products at a time are only 5%.

<img width="928" alt="Image" src="https://github.com/user-attachments/assets/7fa309d2-f7f2-4f9d-924a-edb151d07c46" />

I tried a different principle of customer segmentation and considered those who take up to 10 units of the same type of product in one order as retailers. But in this case, the average number of products in the account for retail customers is 224. Which is also more similar to the behavior of wholesale customers.

File: [avg_quantity_in_order_retail.sql](https://github.com/MariiaDuk/e_commerce_analysis/blob/main/sql/avg_quantity_in_order_retail.sql)

It seems that our online retail store mostly works with wholesale customers. We need to find out how the store divides its customers into retail and wholesale and which of them it defines as target customers.

**Geography**

The store has a wide geography of customers — 38 countries, but sales in other countries are only 17%. It seems that the development of sales abroad is not a priority. At the same time, if today there is already an established system of accepting payments and deliveries with such a large number of countries, it may be appropriate to explore the development of the foreign direction.

For example, if the store achieve that in each country there will be at least 100 orders per year with a median average check by country, this will bring almost 11M additional sales per year (here and further I mean for the same period as in the dataset). 

[Calculation](https://docs.google.com/spreadsheets/d/1cm8srBiv_cOUsSwu1-tnxXSMe-4KDY4kWJIipHmnJdM/edit?gid=1124140124#gid=1124140124).

**Product portfolio**

The store has a wide product portfolio, and there are products that are sold in small quantities. For example, 29,52% of products were sold in quantities of less than 100 during the year. This brought only 0,87% of all sales, but it loads the assortment and, perhaps, even takes up space in the warehouse. And for example products purchased in quantities of up to 500 occupy 53,13% of the entire portfolio, but bring in only 5,82% of sales.

So I would recommend reviewing the product portfolio. The store can abandon unpopular ones, focus on promoting popular ones and try to add something new. This can also help with inventory management and reduce the number of cancelled items due to out-of-stock.

Here it would be very useful to understand not only the names of products, but also their categories, so I would also suggest adding such information to the database.

**Weekdays**

The data shows no transactions occurred on Tuesdays throughout the entire period. To understand why, we need to contact store representatives. Possible reasons include data collection or transmission problems, the store being closed on Tuesdays, or a specific order processing feature.

If the reason is that the store is closed on this day, it would be advisable to consider hiring additional employees and making this day a working day. Even if sales on this day are the same as on Wednesday, the day with the lowest sales, this will give more than 5 million additional sales per year.

<img width="1088" alt="Image" src="https://github.com/user-attachments/assets/eebef257-4543-4bc9-88a9-7abebc1c6a32" />

At the same time, the store needs to make sure that the average sales amount for other days of the week does not fall, otherwise it will not be additional profit, but simply a redistribution of sales between days of the week.

**Top products**

We know which products are ordered in the largest quantities, I would recommend carefully monitoring the stocks of such products to always be ready for large wholesale orders. These products are also among the leaders in top by sales.

<img width="1088" alt="Image" src="https://github.com/user-attachments/assets/6a93da02-65d2-4716-9524-bb46083cf872" />

If we talk about the products that are ordered most often (present in the largest number of invoices), these are mostly other products. I would recommend keeping them in mind when choosing products for advertising.

<img width="1088" alt="Image" src="https://github.com/user-attachments/assets/6f445484-d26a-4ff9-995f-1a2767cd7b71" />

**New Customers**

The store is retaining customers well, while the number of new customers has a negative trend. It would be more correct to build this graph over a longer period of time, but in any case I would suggest tracking this indicator and working with it.

<img width="1088" alt="Image" src="https://github.com/user-attachments/assets/a3290e6e-a3ba-4711-9802-b55036d5dd87" />

**Outliers**

I found two orders-outliers, which I checked not only in Tableau, but also in SQL. 

File: [top_canceled_orders.sql](https://github.com/MariiaDuk/e_commerce_analysis/blob/main/sql/top_canceled_orders.sql)

There are two successfully paid orders in the dataset with the largest number of units of goods (TransactionNo = 581483 and 541431). Among the canceled orders there are also two outliers with the same number of goods from the same customers (TransactionNo = C581484 and C541433).

This table contains information about all orders from these customers.

<img width="1174" alt="Image" src="https://github.com/user-attachments/assets/bd91cbac-a497-4c58-8c10-45492789d30f" />

What we see:

- The TransactionNo numbers show that the canceled orders were created immediately after the paid orders. This was not a massive system failure, because everything was fine with other orders on those days.
- The customer who placed the order on 2019-01-18 has not returned. We need to make sure that this is not related to this situation.
- The canceled order C581484 was for some reason issued with a lower product price.

The situation is worth paying attention to, we need to contact the store representatives to discuss it. Perhaps something was done that led to the loss of a large wholesale customer. In the future, it would be useful to collect data about the reasons for cancellations. However, the justification for this step depends on the order processing process.

# Summary

In order for a business to develop and generate more profit, it is necessary to form a strategy with a clear focus. Three main issues that require attention:

1. Defining the target customer.
2. Developing an international direction.
3. Optimizing the product portfolio.

I see the following plan as the most profitable:

1. Focus on B2B sales.
2. Allocating resources to promotion in other countries.
3. Reducing the assortment.
