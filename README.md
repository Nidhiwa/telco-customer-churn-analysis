# Telco Customer Churn & Revenue Analysis

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Nidhiwa/telco-customer-churn-analysis/blob/main/notebooks/Telco_Churn_Analysis.ipynb)

A beginner-level exploratory data analysis (EDA) project. I used **Python (Pandas, NumPy)**, **SQL (SQLite)**, **Matplotlib** and **Seaborn** to find out which telecom customers leave (churn) and how much monthly revenue those customers represent. I built it to practise the analyst workflow: clean the data, ask business questions, query with SQL, visualize, and recommend actions.

> **Note:** The data is a public IBM sample dataset, so the results show analysis technique and may not match any real company.

---

## 1. Business Problem

Keeping a customer is usually cheaper than winning a new one, so telecom companies watch **churn** (customers who cancel). I set out to answer:

1. What is the overall churn rate, and how much monthly and annualized revenue do churned customers represent?
2. Which contract types, tenure groups and bill levels have the highest churn?
3. Which add-on services are linked to lower churn?

## 2. Dataset

- **Source:** IBM Sample Data Sets, Telco Customer Churn ([CSV link](https://github.com/IBM/telco-customer-churn-on-icp4d/blob/master/data/Telco-Customer-Churn.csv))
- **Size:** 7,043 customers, 21 columns, no duplicate customer IDs
- **Column groups:** demographics, account info (tenure, contract, billing, charges), subscribed services, and the target `Churn` (Yes/No: did the customer leave in the last month)

## 3. What I Did

1. **Data audit and cleaning (Pandas)**
   - `TotalCharges` was stored as text because 11 rows held blank spaces. All 11 had `tenure = 0` (brand-new customers not yet billed), so I filled them with 0.
   - Created `Churn_Flag` (1 = churned, 0 = stayed) so churn rate is simply the average of the flag.
   - Grouped tenure (0-72 months) into four cohorts: 0-1, 1-2, 2-4 and 4-6 years.
2. **SQL analysis (SQLite)**
   - Wrote the cleaned data to a SQLite database file (`telco.db`) and used `COUNT`, `SUM`, `AVG`, `CASE WHEN`, `GROUP BY` and `ROUND` to get churn rate and revenue lost for each segment.
3. **Visualization (Matplotlib, Seaborn)**
   - Bar charts with value labels, a density (KDE) plot of monthly charges for churned vs retained customers, and a heatmap of churn by Tech Support and Online Security.

## 4. Key Findings

| Question | Finding |
|---|---|
| Overall churn | **26.54%** (1,869 of 7,043 customers) |
| Revenue from churned customers | **$139,130.85 per month** (about **$1.67M** a year), roughly **30%** of the $456,117 total monthly revenue |
| Contract type | Month-to-month churn is **42.71%**, one-year **11.27%**, two-year **2.83%**. Month-to-month customers account for **$120,847/month (about 87%)** of the lost revenue |
| Tenure | Customers in their first year churn at **47.44%**, falling to **28.71%**, **20.39%** and **9.51%** in later cohorts |
| Add-on services | Customers with **neither** Tech Support nor Online Security churn at **49.0%**. Customers with **both** churn at **9.0%** |


**Terms I had to learn**
- **Churn rate** = churned customers / all customers in a group. Example: 47.44% of first-year customers left.
- **Share of churn** = a group's churned customers / all churned customers. This is a different number from churn rate.
- **Revenue lost** = monthly charges of customers who already churned. I first called this "at risk", but they have already left, so "lost" is more accurate. *Revenue at risk* would mean customers who might still leave.

## 5. Recommendations (ideas to test, not proven results)

1. **Move month-to-month customers to longer contracts**, for example with a loyalty discount toward a 1-year plan. The discount percentage should come from comparing its cost with the revenue kept; I did not model that.
2. **Strengthen the first year** with onboarding check-ins and early billing reviews, since first-year churn is highest.
3. **Test bundling Tech Support and Online Security.** The heatmap shows a strong link, but it does not prove the add-ons cause lower churn. Customers who buy them may already be more loyal, so a controlled trial (A/B test) is the right next step.

## 6. Limitations

- A single snapshot in time, with no information on *why* customers left
- Association, not causation
- No cost, competitor, satisfaction or customer-service data
- Sample dataset, not a real company

## 7. What I Learned

- Checking data types and hidden blanks before analysis
- Churn rate vs share of total churn
- Cohorts reveal patterns that overall averages hide
- Using Python and SQL together
- Turning numbers into recommendations while being honest about what the data cannot prove

## 8. Repository Structure & How to Run

```
telco-customer-churn-analysis/
├── README.md
├── requirements.txt
├── .gitignore
├── sql/queries.sql
└── notebooks/
    └── Telco_Churn_Analysis.ipynb
```

Click the Colab badge above and choose **Runtime > Run all**. The notebook downloads the CSV from IBM's GitHub itself.
