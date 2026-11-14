# Telco Customer Churn & Revenue Risk Analysis

An end-to-end exploratory data analysis and customer segmentation project using **Python (Pandas, NumPy)**, **SQL (SQLite)**, **Matplotlib**, and **Seaborn** to identify primary churn drivers and quantify recurring revenue at risk.

---

## 1. Business Problem
Acquiring new telecommunications customers costs significantly more than retaining existing subscribers. This project analyzes customer demographics, contract terms, tenure, billing, and service subscriptions to answer three core business questions:
1. What is the overall customer churn rate, and how much monthly and annualized recurring revenue is at risk?
2. Which contract types, tenure cohorts, and billing levels drive the highest customer attrition?
3. Which service add-ons act as the strongest retention levers?

---

## 2. Dataset Source
* **Source:** **IBM Sample Data Sets – Telco Customer Churn** (hosted on IBM's official GitHub repository: [`IBM/telco-customer-churn-on-icp4d`](https://github.com/IBM/telco-customer-churn-on-icp4d/blob/master/data/Telco-Customer-Churn.csv)).
* **Size & Scope:** **7,043 customer records** across **21 attributes**, including:
  * **Customer Demographics:** Gender, senior citizen status, partner, and dependents.
  * **Account Information:** Tenure (months), contract type (`Month-to-month`, `One year`, `Two year`), paperless billing, payment method, monthly charges, and total charges.
  * **Subscribed Services:** Phone service, multiple lines, internet service (`DSL`, `Fiber optic`, `No`), online security, online backup, device protection, tech support, streaming TV, and streaming movies.
  * **Target Variable:** `Churn` (`Yes` / `No` — whether the customer left within the last month).

---

## 3. Tech Stack & Data Pipeline
* **Exploratory Data Audit & Cleaning (`Pandas`, `NumPy`):**
  * Audited raw schema types and uncovered **11 hidden whitespace records** in `TotalCharges` masked as `object` strings—verifying that all 11 belonged to newly onboarded (`tenure = 0`) customers before imputing `$0.00`.
  * Engineered a binary `Churn_Flag` (`1`/`0`) for SQL rate aggregations and segmented continuous tenure months (`0–72`) into four business cohorts (`0–1 Year`, `1–2 Years`, `2–4 Years`, `4–6 Years`).
* **Relational Querying (`SQLite` via `sqlite3`):**
  * Loaded cleaned records into an in-memory SQLite relational database (`telco_customers`) and executed analytical SQL queries (`CASE WHEN`, `GROUP BY`, `ROUND`) to calculate churn rates and dollar revenue at risk across segments.
* **Data Visualization (`Matplotlib`, `Seaborn`):**
  * Built multi-panel bar charts with direct data labels, kernel density estimate (KDE) distributions comparing retained vs. churned monthly charges, and a service add-on churn heatmap.

---

## 4. Key Analytical Findings

| Metric / Segment | Finding | Business Impact |
| :--- | :--- | :--- |
| **Overall Churn Rate** | **26.54%** (1,869 / 7,043 customers) | High baseline attrition requiring targeted retention campaigns |
| **Revenue at Risk** | **~$139,130 / month** | **~$1.67M** in annualized recurring revenue lost |
| **Month-to-Month Contracts** | **42.7% churn rate** | Accounts for **>86%** (~$120,847/mo) of total monthly revenue lost (vs. **2.8%** for 2-year contracts) |
| **First-Year Cohort (`0–1 Year`)** | **47.4% churn rate** | Nearly half of all customer churn occurs within the first 12 months |
| **Service Add-On Gap** | **>48% churn** without add-ons | Customers lacking **Tech Support** and **Online Security** churn at more than double the rate of bundled subscribers |

---

## 5. Strategic Recommendations
1. **Contract Migration Incentives:** Offer a 10–15% loyalty discount or complimentary speed tier upgrade to migrate **Month-to-Month** subscribers onto **1-Year contracts**, directly addressing 86% of monthly revenue loss.
2. **First-90-Day Onboarding Cadence:** Deploy proactive onboarding check-ins and billing reviews during the **0–12 month window** to curb early-lifecycle attrition.
3. **Security & Support Bundling:** Include **Tech Support** and **Online Security** free for the first 6 months for high-bill subscribers ($70–$100/month) to increase product stickiness.

---

## 6. Repository Structure & How to Run
```text
telco-churn-analysis/
├── README.md                                        # Project documentation, dataset details & key findings
└── notebooks/
    └── Telco_Customer_Churn_Analysis.ipynb          # Complete Google Colab notebook (Python + SQL + Charts)
