# Insights and Findings
## Introduction
This project explores sales and customer data from Duka Smart Electronics using PostgreSQL. The aim was to get a better understanding of how the business is performing, which product categories contribute most to its revenue, how customers interact with the business and where there might be room for improvement.

The dataset contains 150 customers and 800 orders recorded between January 2025 and September 2026. Through a series of SQL queries, I explored different aspects of the business, from basic sales figures to customer behaviour, revenue trends and profitability.

## Key Findings
### 1. Sales Performance
The business recorded Ksh 24,155,371.70 in revenue from completed orders. The average value of a completed order was Ksh 38,099.96.

### 2. Revenue by Product Category
Mobile Phones generated the highest revenue at Ksh 6,942,060.65, followed closely by Computing at Ksh 6,596,221.70. Electronics contributed Ksh 5,515,359.20, while Home Appliances generated Ksh 4,024,234.05. Accessories recorded the lowest revenue at Ksh 1,077,496.10.

Mobile Phones and Computing together account for approximately 56% of total completed-order revenue. This suggests that these two categories are particularly important to the business's overall sales.

Accessories, on the other hand, contributes only about 4.46%. This is worth looking into.

### 3. Order Cancellations
Out of the 800 recorded orders, 90 were cancelled, giving the business a cancellation rate of 11.25%.
This means that roughly one in every nine orders was cancelled. 

### 4. Monthly Revenue Trends
I used the `lag()` window function to compare revenue across consecutive months and calculate month-on-month changes.
The results show that monthly revenue did not remain consistent throughout the period. Looking at the first seven months displayed in the query results:

- January 2025 recorded Ksh 434,902.7
- February decreased to Ksh 369,565.6, a decline of approximately 15.02%.
- March saw a considerable increase to Ksh 735,247.55, representing growth of approximately 98.95%.
- April dropped by approximately 13.96%, with revenue at Ksh 632,642.9.
- May recovered to Ksh 682,628.6 an increase of approximately 7.90%.
- June recorded a further increase to Ksh 772,390.35.
- July recorded Ksh 1,235,096.25, representing growth of approximately 59.90% from June.

These changes suggest that the business experiences noticeable fluctuations in monthly revenue. March and July, in particular, stand out as months with significant changes compared to the preceding month.

## Recommendations
Based on the findings so far, I would recommend that the business:
1. **Pay closer attention to its leading categories** - Mobile Phones and Computing contribute more than half of completed-order revenue. Maintaining good stock levels and monitoring demand in these categories could help protect this important source of revenue.
2. **Investigate the Accessories category** - Its contribution is considerably lower than that of the other categories. Before making decisions about its product range, management should examine sales volumes, pricing and profitability to understand what is happening.
3. **Look into order cancellations** - Understanding where and why cancellations occur could help the business identify issues in its payment, stock management or fulfilment processes.
4. **Monitor monthly sales patterns** - The fluctuations in monthly revenue make it useful to keep track of performance over time and investigate unusually high or low months.

## Limitations and Further Analysis
- The cancellation rate does not explain the reasons behind cancelled orders. More detailed analysis of cancellation patterns across products, payment methods and customer segments would be useful.
- Further analysis of customer spending, repeat purchases and customer segments could also help the business understand who its most valuable customers are and how purchasing behaviour differs across groups.