-- Table: telco_customers (cleaned data written from Pandas to SQLite)
-- Churn_Flag: 1 = churned, 0 = stayed | Tenure_Group: 0-1, 1-2, 2-4, 4-6 Years

-- Query 1: Overall KPIs
SELECT
    COUNT(customerID) AS Total_Customers,
    SUM(Churn_Flag) AS Churned_Customers,
    ROUND(AVG(Churn_Flag) * 100, 2) AS Overall_Churn_Rate_Pct,
    ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Revenue,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS Monthly_Revenue_Lost,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 12, 2) AS Annualized_Revenue_Lost
FROM telco_customers;

-- Query 2: Churn and revenue lost by contract type
SELECT
    Contract,
    COUNT(customerID) AS Customers,
    SUM(Churn_Flag) AS Churned,
    ROUND(AVG(Churn_Flag) * 100, 2) AS Churn_Rate_Pct,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charge,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS Monthly_Revenue_Lost
FROM telco_customers
GROUP BY Contract
ORDER BY Churn_Rate_Pct DESC;

-- Query 3: Churn rate by tenure cohort
SELECT
    Tenure_Group,
    COUNT(customerID) AS Customers,
    ROUND(AVG(Churn_Flag) * 100, 2) AS Churn_Rate_Pct
FROM telco_customers
GROUP BY Tenure_Group;

-- Query 4: Share of all churn by tenure cohort
SELECT
    Tenure_Group,
    SUM(Churn_Flag) AS Churned_Customers,
    ROUND(100.0 * SUM(Churn_Flag) / (SELECT SUM(Churn_Flag) FROM telco_customers), 1) AS Pct_of_All_Churn
FROM telco_customers
GROUP BY Tenure_Group;

-- Query 6: Churn by internet service type
SELECT
    InternetService,
    COUNT(*) AS Customers,
    SUM(Churn_Flag) AS Churned,
    ROUND(AVG(Churn_Flag) * 100, 2) AS Churn_Rate_Pct,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charge,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS Monthly_Revenue_Lost
FROM telco_customers
GROUP BY InternetService
ORDER BY Churn_Rate_Pct DESC;

-- Query 7: Add-on effect within Fiber optic customers
SELECT
    TechSupport,
    OnlineSecurity,
    COUNT(*) AS Customers,
    ROUND(AVG(Churn_Flag) * 100, 1) AS Churn_Rate_Pct
FROM telco_customers
WHERE InternetService = 'Fiber optic'
GROUP BY TechSupport, OnlineSecurity
ORDER BY Churn_Rate_Pct DESC;
