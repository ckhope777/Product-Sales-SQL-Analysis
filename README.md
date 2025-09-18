# Product-Sales-SQL-Analysis
This project uses MySQL to analyze the sales, customer feedback, and operational performance of New-Wheels, a vehicle sales company facing a steady decline in new customers and revenue. The dataset was originally unstructured, dumped as flat files. Using SQL queries, the data was organized and analyzed to extract business insights.

## Problem Statement ##

### New-Wheels has been facing: ###
 - Declining sales in the past year.
 - Negative customer feedback and ratings.
 - Drop in new customers every quarter.
 - Disorganized data stored as flat files, used only occasionally.

**Business Need:**
Leadership requires a clear understanding of customer trends, revenue performance, and shipping efficiency to make data-driven decisions and improve both sales and customer experience.

## Approach Taken ##

**1. Data Understanding & Cleaning**
 - Data from customers, products, and orders was cleaned and structured into tables (customer_t, order_t, product_t).

**2. SQL Analysis**
 - Customer Insights:
   - Distribution of customers by state.
   - Average feedback score by quarter.
   - Whether dissatisfaction is increasing over time.
   - Most preferred vehicle makers overall and by state.

 - Revenue & Orders:
   - Trend of orders across quarters.
   - Quarter-over-quarter % change in revenue.
   - Combined view of revenue and orders per quarter.

 - Shipping & Discounts:
   - Average discounts by credit card type.
   - Average shipping time by quarter.

**3.Visualization & Reporting**
 - SQL query outputs were visualized (e.g., bar charts, line graphs).
 - Final insights summarized into a Quarterly Business Report with actionable recommendations.

## Results & Insights ##
 - Customers:
   - Certain states dominate the customer base.
   - Customer satisfaction has trended downward, with increasing percentages of “Poor” and “Very Poor” feedback over time.
   - Top 5 vehicle makers account for the majority of customer purchases, with preferences varying significantly by state.

 - Revenue & Orders:
   - Orders and revenue showed quarter-to-quarter fluctuations.
   - Quarter-over-quarter revenue growth revealed both positive spikes and alarming declines.
   - Sales dip is closely tied to both reduced order volumes and poor customer retention.

Shipping & Discounts:
  - Credit card type influenced average discounts offered.
  - Shipping times varied by quarter, suggesting operational inefficiencies in certain periods.
