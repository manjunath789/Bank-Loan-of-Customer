--------------------------------------------------- #GROUP 5 BANK ANALYTICS ----------------------------------------------------------------------------------------------
Create database bankanalytics;
use bankanalytics;
select * from mergeddata;
Select STR_TO_DATE(issue_d, '%Y-%m-%d %H:%i:%s')as converted_datetime from mergeddata;
Select year(issue_d) as issue_years from mergeddata;

----------------------------------------------- KPI 1 - YEAR WISE LOAN AMOUNT STATS --------------------------------------------------------------------------------------

SELECT
YEAR(issue_d) AS year_value,
FORMAT(SUM(loan_amnt), 0) AS Total_Amount
FROM
mergeddata
GROUP BY
year_value
ORDER BY
Total_Amount DESC;

----------------------------------------------- KPI 2 - GRADE & SUB-GRADE WISE REVOLVING BALANCE -------------------------------------------------------------------------

SELECT
grade,
sub_grade,
ROUND(AVG(revol_bal), 2) AS avg_revol_bal
FROM
mergeddata
GROUP BY
grade, sub_grade;

----------------------------------------------- KPI 3 - TOTAL PAYMENT FOR VERIFIED STATUS V/S NON-VERIFIED STATS ----------------------------------------------------------

SELECT
verification_status,
FORMAT(ROUND(SUM(total_pymnt), 2), 2) AS Total_Payment
FROM
mergeddata
GROUP BY
verification_status;

----------------------------------------------- KPI 4 - STATEWISE & MONTHWISE LOAN STATS ---------------------------------------------------------------------------------

Select addr_state as State, last_pymnt_d, loan_status,
count(*) as loan_count from mergeddata
group by addr_state, last_pymnt_d, loan_status
order by addr_state, last_pymnt_d, loan_status;

---------------------------------------------- KPI 5 - HOME OWNERSHIP V/S LAST PAYMENT DATE STATS ------------------------------------------------------------------------

Select year(issue_d) as payment_year,
monthname(issue_d)as payment_month,
Home_ownership, count(Home_Ownership) as Home_Ownership from mergeddata
where Home_Ownership in ('Rent', 'Mortage','Own','Others')
group by payment_year, payment_month, Home_Ownership
order by payment_year, Home_Ownership;

---------------------------------------------- KPI 6 - YEAR WISE TOTAL INTEREST RECEIVED ---------------------------------------------------------------------------------

SELECT
YEAR(last_pymnt_d) AS payment_year,
ROUND(SUM(int_rate), 2) AS Total_Interest_received
FROM
mergeddata
GROUP BY
payment_year;

--------------------------------------------------------- END ---------------------------------------------------------------------------------------------------------------