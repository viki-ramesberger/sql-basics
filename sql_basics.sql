/* Task 1. Count how many companies have closed.*/ 

SELECT COUNT(id)
FROM company
WHERE status = 'closed';

/* Task 2. Display the total amount of funds raised by news companies in the USA. Use data from the `company` table. Sort the table in descending order by `funding_total`.*/

-- This query displays the total amount of funds raised by news companies in the USA.
-- The results are ordered in descending order by the `funding_total` column.
SELECT funding_total
FROM company
WHERE category_code = 'news' 
  AND country_code = 'USA'
ORDER BY funding_total DESC;

/* Task 3. Find the total amount of deals where one company acquired another in dollars. Filter the deals that were made exclusively in cash between 2011 and 2013.*/

-- This query calculates the total value of acquisition deals (price_amount) 
-- where the payment term was exclusively cash and the deal was made between 2011 and 2013.
SELECT SUM(price_amount)
FROM acquisition
WHERE term_code = 'cash' AND
      EXTRACT(YEAR FROM acquired_at) BETWEEN 2011 AND 2013;

/* Task 4. Display the first name, last name, and the account names (network_username) of people whose account names start with 'Silver'.*/

-- This query retrieves the first name, last name, and twitter username of people whose twitter username starts with the string 'Silver'.
SELECT first_name,
       last_name,
       twitter_username
FROM people
WHERE twitter_username LIKE 'Silver%';

/* Task 5. Display all information about people whose account names (network_username) contain the substring 'money' and whose last names start with 'K'.*/

-- This query selects all fields from the 'people' table where the network username contains 'money' and the last name starts with the letter 'K'.
SELECT *
FROM people
WHERE twitter_username LIKE '%money%'
  AND last_name LIKE 'K%';

/* Task 6. For each country, display the total amount of investments raised by companies registered in that country. 
The country can be identified by the country code. Sort the data in descending order by the amount.*/

-- This query calculates the total amount of funding raised by companies in each country (identified by country_code)
-- and sorts the results in descending order by the total funding amount.
SELECT country_code,
       SUM(funding_total)
FROM company
GROUP BY country_code
ORDER BY SUM(funding_total) DESC;

/* Task 7. Create a table showing the date of the funding round, as well as the minimum and maximum investment amounts raised on that date. 
Keep only those records where the minimum investment amount is not zero and not equal to the maximum amount.*/

-- This query returns the date of each funding round along with the minimum and maximum amounts raised on that date,
-- while excluding rounds where the minimum raised amount is 0 or equal to the maximum raised amount.
SELECT funded_at,
       MIN(raised_amount),
       MAX(raised_amount)
FROM funding_round
GROUP BY funded_at
HAVING MIN(raised_amount) != 0 AND 
       MIN(raised_amount) != MAX(raised_amount);


/* Task 8. Create a category field:
- For funds that invest in 100 or more companies, assign the category `high_activity`.
- For funds that invest in 20 to 99 companies, assign the category `middle_activity`.
- For funds that invest in fewer than 20 companies, assign the category `low_activity`.
Display all columns from the `fund` table along with the new category field.*/

-- This query assigns a category based on the number of companies each fund has invested in.
-- Funds investing in 100 or more companies are categorized as 'high_activity', 
-- those investing in 20 to 99 companies as 'middle_activity', 
-- and funds investing in fewer than 20 companies as 'low_activity'.
SELECT *,
CASE 
    WHEN invested_companies >= 100 THEN 'high_activity'
    WHEN invested_companies BETWEEN 20 AND 99 THEN 'middle_activity'
    WHEN invested_companies < 20 THEN 'low_activity'
END
FROM fund;


/* Task 9. For each category assigned in the previous task, calculate the average number of investment rounds in which the fund participated, rounded to the nearest integer. 
Display the categories and the average number of rounds, sorting the table in ascending order of the average.*/

-- This query calculates the average number of investment rounds each fund participated in, 
-- grouped by their activity category ('high_activity', 'middle_activity', 'low_activity'). 
-- The average is rounded to the nearest integer and the results are sorted in ascending order by the average number of rounds.
SELECT CASE
           WHEN invested_companies >= 100 THEN 'high_activity'
           WHEN invested_companies >= 20 THEN 'middle_activity'
           ELSE 'low_activity'
       END AS activity,
       ROUND(AVG(investment_rounds))
FROM fund
GROUP BY activity
ORDER BY ROUND(AVG(investment_rounds));


/* Task 10. Analyze in which countries the funds that invest the most in startups are located. 
For each country, calculate the minimum, maximum, and average number of companies in which funds from that country invested, based on funds established between 2010 and 2012. 
Exclude countries with funds that have a minimum number of companies receiving investments equal to zero. 
Display the ten most active investor countries, sorted by the average number of companies from highest to lowest. 
Then, add sorting by country code in lexicographical order.*/

-- This query analyzes the funds from countries that invested the most in startups, 
-- calculating the minimum, maximum, and average number of companies funded by each country's funds,
-- for funds established between 2010 and 2012. It excludes countries where the minimum number of companies is zero,
-- and displays the top 10 most active investor countries, sorted by the average number of companies invested in and then by country code.

SELECT country_code,
       MIN(invested_companies),
       MAX(invested_companies),
       AVG(invested_companies)
FROM fund
WHERE EXTRACT(YEAR FROM founded_at) BETWEEN 2010 AND 2012
GROUP BY country_code
HAVING MIN(invested_companies) != 0
ORDER BY AVG(invested_companies) DESC
LIMIT 10;












/* Task 11. Display the first name and last name of all employees of startups. 
Include a field for the name of the educational institution the employee graduated from, if this information is available.*/

--
--
SELECT p.first_name,
p.last_name,
e.instituition
FROM people AS p
LEFT JOIN education AS e ON p.id = e.person_id;

/* Task 12. For each company, find the number of educational institutions its employees graduated from. 
Display the company name and the number of unique educational institutions. 
Create a top-5 list of companies by the number of universities.*/


/* Task 13. Create a list of unique names of closed companies for which the first funding round was the last.*/

--
--

/* Task 14. Create a list of unique employee numbers of employees working in the companies selected in the previous task.*/


/* Task 15. Create a table with unique pairs of employee numbers (from the previous task) and the educational institution the employee graduated from.*/


/* Task 16. Count the number of educational institutions for each employee from the previous task. 
Take into account that some employees may have graduated from the same institution twice.*/


/* Task 17. Extend the previous query and display the average number of educational institutions (all, not just unique) that employees from different companies graduated from. 
Only one record should be displayed, so no grouping is required.*/


/* Task 18. Write a similar query: display the average number of educational institutions (all, not just unique) that employees from Facebook graduated from.*/


/* Task 19. Create a table with the following fields:
`name_of_fund` — name of the fund;
`name_of_company` — name of the company;
`amount` — the amount of investment raised by the company in the round.
The table should include data on companies that have more than six important milestones in their history, and where funding rounds occurred between 2012 and 2013.*/


/* Task 20. Export a table with the following fields:
- Buyer company name;
- Deal amount;
- Name of the acquired company;
- Amount of investments made in the acquired company;
- The ratio showing how many times the purchase amount exceeded the amount of investments made in the company, rounded to the nearest integer.
Exclude deals where the purchase amount is zero. If the investment amount in the company is zero, exclude that company from the table.
Sort the table by deal amount in descending order, then by the name of the acquired company in lexicographical order. Limit the table to the first ten records.*/


/* Task 21. Export a table with the names of companies from the social category that received funding between 2010 and 2013. 
Ensure that the investment amount is not zero. 
Also, display the month number in which the funding round took place.*/


/* Task 22. Filter data for the months between 2010 and 2013 when investment rounds took place. Group the data by the month number and create a table with the following fields:
- The month number in which the rounds took place;
- The number of unique US-based funds that invested in that month;
- The number of companies acquired in that month;
- The total amount of deals for acquisitions in that month.*/


/* Task 23. Create a pivot table and display the average investment amount for countries with startups registered in 2011, 2012, and 2013. 
Data for each year should be in a separate field. Sort the table by the average investment value for 2011 in descending order.*/
