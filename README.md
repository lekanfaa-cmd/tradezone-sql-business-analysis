# TradeZone SQL Business Analysis

## Project Overview

This project presents a business-focused SQL analysis conducted for TradeZone, a rapidly growing Nigerian e-commerce platform operating across Lagos, Abuja, Kano, Port Harcourt, and Ibadan.

The objective of the analysis was to investigate operational inefficiencies, customer behavior, seller performance, product trends, and revenue patterns using PostgreSQL. The project combines data cleaning, SQL querying, and analytical reporting to support executive decision-making ahead of the company’s 2025 planning cycle.

---

# Business Problem

TradeZone experienced rapid growth between 2023 and 2024, but leadership identified several emerging concerns including:

- Declining customer retention
- Poor seller performance
- Underperforming product categories
- Operational inefficiencies
- Inconsistent platform ratings

The Head of Growth and the Head of Seller Operations requested a detailed business analysis to uncover actionable insights and support strategic planning.

---

# Project Objectives

The analysis aimed to:

- Clean and validate operational datasets
- Identify customer acquisition and conversion trends
- Evaluate seller fulfilment efficiency
- Analyze product and revenue performance
- Understand customer spending behavior
- Investigate payment method preferences
- Assess review ratings and sales relationships
- Identify top-performing sellers

---

# Tools & Technologies Used

| Tool | Purpose |
|---|---|
| PostgreSQL | SQL Querying & Data Analysis |
| SQL | Data Cleaning & Business Analysis |
| Excel | Initial Data Inspection |
| GitHub | Documentation & Portfolio Hosting |

---

# Data Cleaning & Preparation

Before analysis, several data quality issues were identified and resolved.

## Cleaning Tasks Performed

- Handling missing values
- Removing duplicate records
- Standardizing city and category formatting
- Validating order totals
- Verifying rating ranges
- Detecting invalid pricing and discount values

The cleaning process ensured improved reliability and consistency across all analytical queries.

---

# Business Questions Answered

## Question 1 – Customer Acquisition & 30-Day Conversion

Analyzed the top-performing states based on customer sign-ups and measured early customer conversion rates.

### Business Focus
- Customer acquisition quality
- Conversion effectiveness

---

## Question 2 – Product Performance

Identified the highest revenue-generating products and categories during 2024.

### Business Focus
- Revenue concentration
- Product profitability

---

## Question 3 – Seller Fulfilment Efficiency

Measured seller delivery efficiency and customer satisfaction performance.

### Business Focus
- Operational efficiency
- Seller performance monitoring

---

## Question 4 – Quarterly Revenue Trends

Compared quarterly business performance across 2023 and 2024.

### Business Focus
- Revenue growth trends
- Seasonal performance analysis

---

## Question 5 – Customer Spend Segmentation

Segmented customers based on spending behavior.

### Business Focus
- Customer value analysis
- Revenue contribution segmentation

---

## Question 6 – Payment Method Preferences by State

Evaluated transaction behavior across payment channels and locations.

### Business Focus
- Payment behavior analysis
- Regional transaction trends

---

## Question 7 – Review Ratings & Sales Performance

Investigated the relationship between customer ratings and revenue performance.

### Business Focus
- Product quality perception
- Revenue impact of ratings

---

## Question 8 – Top Seller Bonus Qualification

Identified top-performing sellers eligible for performance incentives.

### Business Focus
- Seller reward strategy
- Revenue contribution analysis

---

# Key Business Insights

The analysis revealed several critical findings:

- Customer acquisition growth varied significantly by state
- High-rated products consistently generated stronger revenue performance
- Certain sellers demonstrated operational inefficiencies affecting delivery speed
- Revenue growth was concentrated within a small number of products and sellers
- Payment preferences differed considerably across regions

These findings provide actionable intelligence for improving customer retention, operational performance, and revenue growth.

---

# Repository Structure

```plaintext
tradezone-sql-business-analysis/

│── README.md
│
├── sql/
│     ├── part_1_data_cleaning.sql
│     ├── q1_customer_acquisition.sql
│     ├── q2_product_performance.sql
│     ├── q3_seller_fulfilment_efficiency.sql
│     ├── q4_quarterly_revenue_trends.sql
│     ├── q5_customer_spend_segmentation.sql
│     ├── q6_payment_method_preferences.sql
│     ├── q7_review_ratings_sales_performance.sql
│     └── q8_top_seller_bonus_qualification.sql
│
├── report/
│     └── analyst_memo.pdf
│
└── dataset/
      └── cleaned_database_dump.sql
```

---

# Skills Demonstrated

- SQL Querying
- PostgreSQL
- Data Cleaning
- Business Analysis
- Data Validation
- Analytical Thinking
- Stakeholder Reporting
- Operational Intelligence

---

# Conclusion

This project demonstrates how SQL can be applied beyond technical querying to solve real business problems and support strategic decision-making.

The analysis transformed raw operational data into actionable insights capable of guiding customer growth, seller management, operational efficiency, and revenue optimization strategies.

---

# Author

Lekan Ajayi  
Data Analyst | Business Intelligence Enthusiast
