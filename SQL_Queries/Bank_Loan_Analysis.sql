--KPIs Requirement(Dashboard - 1st)

SELECT * FROM financial_loan;
--Query : 1

SELECT COUNT(id) AS Total_Loan FROM financial_loan;

SELECT COUNT(id) AS MTD_Total_Loan FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT COUNT(id) AS PMTD_Total_Loan FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Query : 2

SELECT SUM(loan_amount) as Total_Funded_Amount FROM financial_loan

SELECT SUM(loan_amount) as MTD_Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(loan_amount) as PMTD_Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Query : 3

SELECT SUM(total_payment) as Total_Amount_Recevied From financial_loan

SELECT SUM(total_payment) as MTD_Total_Amount_Recevied From financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(total_payment) as MTD_Total_Amount_Recevied From financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


--Query : 4

SELECT ROUND(AVG(int_rate),4)*100 as Average_Interest_Rate FROM financial_loan

SELECT ROUND(AVG(int_rate),4)*100 as MTD_Average_Interest_Rate FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(int_rate),4)*100 as PMTD_Average_Interest_Rate FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Query : 5

SELECT ROUND(AVG(dti),4)*100 as Average_DTI FROM financial_loan

SELECT ROUND(AVG(dti),4)*100 as MTD_Average_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(dti),4)*100 as PMTD_Average_DTI FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- GOOD VS BAD LOAN

-- Good Loan
SELECT
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END))*100/
	COUNT(id) AS Good_Loan
FROM financial_loan;

SELECT COUNT(id) as Good_Loan_Application From financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; 

SELECT SUM(loan_amount) as Good_Loan_Funded_Amount From financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; 

SELECT SUM(total_payment) as Good_Loan_Recevied_Amount From financial_loan
WHERE loan_status = 'Charged Off';

-- Bad Laon
SELECT
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END))*100.0/
	COUNT(id) AS Bad_Loan
FROM financial_loan;

SELECT COUNT(id) as Bad_Loan_Application From financial_loan
WHERE loan_status = 'Charged Off'; 

SELECT SUM(loan_amount) as Bad_Loan_Funded_Amount From financial_loan
WHERE loan_status =  'Charged Off'; 

SELECT SUM(total_payment) as Bad_Loan_Recevied_Amount From financial_loan
WHERE loan_status =  'Charged Off';

--Loan Status
SELECT 
	loan_status,
	COUNT(id) as Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Receive_Amount,
	AVG(int_rate) as Average_LInterest_Rate,
	AVG(dti) as AVERAGE_DTI
FROM financial_loan 
GROUP BY loan_status;

SELECT 
	loan_status,
	SUM(loan_amount) as _MTD_Total_Funded_Amount,
	SUM(total_payment) as MDT_Total_Amount_Recevied
FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status


--Chart(Dashboard - 2)
SELECT * FROM financial_loan

SELECT 
	MONTH(issue_date) as Month_Number,
	DATENAME(MONTH,issue_date) as Month_Name,
	COUNT(id) as Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recevied
FROM financial_loan
GROUP BY issue_date
ORDER BY issue_date 

SELECT 
	address_state,
	COUNT(id) as Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recevied
FROM financial_loan
GROUP BY address_state
ORDER BY Total_Application

SELECT 
	term,
	COUNT(id) as Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recevied
FROM financial_loan
GROUP BY term
ORDER BY term 

SELECT 
	emp_length,
	COUNT(id) as Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recevied
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length


SELECT 
	purpose,
	COUNT(id) as Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recevied
FROM financial_loan
GROUP BY purpose
ORDER BY Total_Application DESC 

SELECT 
	home_ownership,
	COUNT(id) as Total_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recevied
FROM financial_loan
WHERE grade = 'A'
GROUP BY home_ownership
ORDER BY Total_Application DESC
