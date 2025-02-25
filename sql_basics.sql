/* Task 1. Count how many companies have closed. */
-- This query counts the number of companies that are closed by checking the 'status' field for 'closed' companies.
SELECT COUNT(id)
FROM company
WHERE status = 'closed';

/* Task 2. Display the total amount of funds raised by news companies in the USA. Use data from the `company` table. Sort the table in descending order by `funding_total`. */

-- This query retrieves the total amount of funds raised by companies in the 'news' category in the USA, sorted by the total funding amount in descending order.
SELECT funding_total
FROM company
WHERE category_code = 'news' 
  AND country_code = 'USA'
ORDER BY funding_total DESC;

/* Task 3. Find the total amount of deals where one company acquired another in dollars. Filter the deals that were made exclusively in cash between 2011 and 2013. */

-- This query calculates the total deal amount where the transaction was exclusively in cash, filtered by the years between 2011 and 2013.
SELECT SUM(price_amount)
FROM acquisition
WHERE term_code = 'cash' AND
      EXTRACT(YEAR FROM acquired_at) BETWEEN 2011 AND 2013;

/* Task 4. Display the first name, last name, and the account names (network_username) of people whose account names start with 'Silver'. */

-- This query retrieves the first name, last name, and Twitter username of people whose username starts with 'Silver'.
SELECT first_name,
       last_name,
       twitter_username
FROM people
WHERE twitter_username LIKE 'Silver%';

/* Task 5. Display all information about people whose account names (network_username) contain the substring 'money' and whose last names start with 'K'. */

-- This query retrieves all details about people whose Twitter username contains 'money' and whose last name starts with 'K'.
SELECT *
FROM people
WHERE twitter_username LIKE '%money%'
  AND last_name LIKE 'K%';

/* Task 6. For each country, display the total amount of investments raised by companies registered in that country. 
   The country can be identified by the country code. Sort the data in descending order by the amount. */

-- This query sums the total investment raised by companies in each country, sorted in descending order by the investment amount.
SELECT country_code,
       SUM(funding_total)
FROM company
GROUP BY country_code
ORDER BY SUM(funding_total) DESC;

/* Task 7. Create a table showing the date of the funding round, as well as the minimum and maximum investment amounts raised on that date. 
   Keep only those records where the minimum investment amount is not zero and not equal to the maximum amount. */

-- This query creates a table of funding rounds showing the date and the minimum and maximum investment amounts, filtering out records where the minimum amount is zero or equal to the maximum amount.
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
   Display all columns from the `fund` table along with the new category field. */

-- This query categorizes funds based on the number of companies they have invested in and displays the full details from the `fund` table along with the assigned category.
SELECT *,
CASE 
    WHEN invested_companies >= 100 THEN 'high_activity'
    WHEN invested_companies BETWEEN 20 AND 99 THEN 'middle_activity'
    WHEN invested_companies < 20 THEN 'low_activity'
END
FROM fund;

/* Task 9. For each category assigned in the previous task, calculate the average number of investment rounds in which the fund participated, rounded to the nearest integer. 
   Display the categories and the average number of rounds, sorting the table in ascending order of the average. */

-- This query calculates the average number of investment rounds for each category (created in the previous task), rounding the results to the nearest integer, and sorts by the average in ascending order.
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

-- Fetch the first and last names of employees and their educational institutions, if available
SELECT p.first_name,
       p.last_name,
       e.instituition
FROM people AS p
-- Use LEFT JOIN to include all employees, even those without education information
LEFT JOIN education AS e ON p.id = e.person_id;

-- This query retrieves the first and last names of employees and their educational institutions. 
-- The LEFT JOIN ensures that even if the education data is missing, the employee will still appear in the result.

/* Task 12. For each company, find the number of educational institutions its employees graduated from. 
   Display the company name and the number of unique educational institutions. 
   Create a top-5 list of companies by the number of universities.*/

-- For each company, find the number of unique educational institutions their employees graduated from
SELECT c.name,
       COUNT(DISTINCT ed.instituition)
FROM company AS c
JOIN people AS p ON c.id = p.company_id
JOIN education AS ed ON p.id = ed.person_id
GROUP BY c.name
-- Sort by the number of unique educational institutions in descending order
ORDER BY COUNT(DISTINCT ed.instituition) DESC
LIMIT 5;

-- This query calculates the number of unique educational institutions for each company. The COUNT(DISTINCT ed.instituition) ensures we count unique institutions. 
-- The results are ordered by the count in descending order, limited to the top 5 companies.

/* Task 13. Create a list of unique names of closed companies for which the first funding round was the last.*/

-- List the closed companies where the first funding round was also the last round
SELECT DISTINCT(c.name)
FROM company AS c
WHERE status = 'closed' AND id IN (SELECT company_id
                                   FROM funding_round
                                   WHERE is_first_round = 1 AND is_last_round = 1);

-- This query selects closed companies where the first funding round was also the last one. 
-- The subquery checks for companies where is_first_round = 1 and is_last_round = 1.

/* Task 14. Create a list of unique employee numbers of employees working in the companies selected in the previous task.*/

-- Get the employee IDs working in the companies selected in the previous task
SELECT p.id
FROM people AS p
WHERE company_id IN (SELECT id
                     FROM company AS c
                     WHERE status = 'closed' 
                     AND id IN (SELECT company_id
                                   FROM funding_round
                                   WHERE is_first_round = 1 
                                           AND is_last_round = 1));

-- This query fetches the employee IDs working in companies that were selected in the previous task (those that are closed and had the first funding round as the last round).

/* Task 15. Create a table with unique pairs of employee numbers (from the previous task) and the educational institution the employee graduated from.*/

-- Create a table with unique pairs: employee ID and the institution they graduated from
SELECT DISTINCT(p.id), e.instituition
FROM people AS p
LEFT JOIN education AS e ON p.id=e.person_id
WHERE company_id IN (SELECT id
                     FROM company AS c
                     WHERE status = 'closed' 
                     AND id IN (SELECT company_id
                                FROM funding_round
                                WHERE is_first_round = 1 
                                AND is_last_round = 1))
                  AND e.instituition IS NOT NULL;

-- This query forms a table with unique pairs: employee ID and their educational institution. We filter out rows where the institution is NULL.

/* Task 16. Count the number of educational institutions for each employee from the previous task. 
   Take into account that some employees may have graduated from the same institution twice.*/

-- Count the number of educational institutions for each employee
SELECT DISTINCT(p.id), COUNT(e.instituition)
FROM people AS p
LEFT JOIN education AS e ON p.id=e.person_id
WHERE company_id IN (SELECT id
                     FROM company AS c
                     WHERE status = 'closed' 
                     AND id IN (SELECT company_id
                                FROM funding_round
                                WHERE is_first_round = 1 
                                AND is_last_round = 1))
                  AND e.instituition IS NOT NULL
GROUP BY p.id;

-- This query counts how many educational institutions each employee has attended, even if they attended the same institution multiple times. 
-- The results are grouped by employee ID.

/* Task 17. Extend the previous query and display the average number of educational institutions (all, not just unique) that employees from different companies graduated from. 
   Only one record should be displayed, so no grouping is required.*/

-- Calculate the average number of educational institutions per employee from the selected companies
WITH i AS (
    SELECT p.id, COUNT(e.instituition) AS institution_count
    FROM people AS p
    LEFT JOIN education AS e ON p.id = e.person_id
    WHERE p.company_id IN (
        SELECT id
        FROM company AS c
        WHERE status = 'closed' 
          AND id IN (
              SELECT company_id
              FROM funding_round
              WHERE is_first_round = 1 
                AND is_last_round = 1
          )
    )
    AND e.instituition IS NOT NULL
    GROUP BY p.id
)

-- Average count of educational institutions
SELECT AVG(institution_count) AS avg_institution_count
FROM i;

-- This query first calculates the number of educational institutions each employee attended and then computes 
-- the average number of institutions across all employees in the selected companies.

/* Task 18. Write a similar query: display the average number of educational institutions (all, not just unique) that employees from Facebook graduated from.*/

-- Calculate the average number of educational institutions for Facebook employees
WITH i AS (
    SELECT p.id, COUNT(e.instituition) AS institution_count
    FROM people AS p
    LEFT JOIN education AS e ON p.id = e.person_id
    WHERE p.company_id IN (
        SELECT id
        FROM company AS c
        WHERE name = 'Facebook'
    )
    AND e.instituition IS NOT NULL
    GROUP BY p.id
)

SELECT AVG(institution_count) AS avg_institution_count
FROM i;

-- This query calculates the average number of educational institutions for Facebook employees, following the same structure as the previous query but specifically for Facebook.

/* Task 19. Create a table with the following fields:
   `name_of_fund` — name of the fund;
   `name_of_company` — name of the company;
   `amount` — the amount of investment raised by the company in the round.
   The table should include data on companies that have more than six important milestones in their history, and where funding rounds occurred between 2012 and 2013.*/

-- Retrieve fund names, company names, and the investment amounts for companies with more than 6 milestones
-- and funding rounds between 2012 and 2013
SELECT f.name AS name_of_fund,
       c.name AS name_of_company,
       fr.raised_amount AS amount
FROM investment AS i
LEFT JOIN company AS c ON i.company_id = c.id
LEFT JOIN fund AS f ON i.fund_id = f.id
LEFT JOIN funding_round AS fr ON i.funding_round_id = fr.id
WHERE c.milestones > 6
  AND EXTRACT(YEAR FROM fr.funded_at) IN (2012, 2013);

-- This query retrieves fund names, company names, and the amount raised for companies with more than 6 milestones and whose funding rounds occurred between 2012 and 2013.

/* Task 20. Export a table with the following fields:
   - Buyer company name;
   - Deal amount;
   - Name of the acquired company;
   - Amount of investments made in the acquired company;
   - The ratio showing how many times the purchase amount exceeded the amount of investments made in the company, rounded to the nearest integer.
   Exclude deals where the purchase amount is zero. If the investment amount in the company is zero, exclude that company from the table.
   Sort the table by deal amount in descending order, then by the name of the acquired company in lexicographical order. Limit the table to the first ten records.*/

-- Retrieve details about acquisitions with uplift calculated as purchase amount divided by investment amount
SELECT c.name AS acquiring_name,
       a.price_amount,
       c2.name AS acquired_name,
       c2.funding_total,
       ROUND((a.price_amount / c2.funding_total)) AS uplift
FROM acquisition AS a
LEFT JOIN company AS c ON a.acquiring_company_id = c.id
LEFT JOIN company AS c2 ON a.acquired_company_id = c2.id
WHERE a.price_amount != 0 AND c2.funding_total != 0
ORDER BY a.price_amount DESC, c2.name
LIMIT 10;

-- This query retrieves data on acquisitions, calculating the uplift ratio as the purchase price divided by the total investment in the acquired company. 
-- We exclude records where the purchase amount or investment amount is zero.

/* Task 21. Export a table with the names of companies from the social category that received funding between 2010 and 2013. 
   Ensure that the investment amount is not zero. 
   Also, display the month number in which the funding round took place.*/

-- Retrieve companies in the 'social' category that raised funds between 2010 and 2013
-- and the month of the funding round
SELECT c.name AS social_co,
       EXTRACT(MONTH FROM fr.funded_at) AS funding_month
FROM company AS c
LEFT JOIN funding_round AS fr ON c.id = fr.company_id
WHERE c.category_code = 'social'
AND fr.funded_at BETWEEN '2010-01-01' AND '2013-12-31'
AND fr.raised_amount <> 0;

-- This query selects social companies that raised funding between 2010 and 2013. It also extracts the month of the funding round.

/* Task 22. Filter data for the months between 2010 and 2013 when investment rounds took place. Group the data by the month number and create a table with the following fields:
   - The month number in which the rounds took place;
   - The number of unique US-based funds that invested in that month;
   - The number of companies acquired in that month;
   - The total amount of deals for acquisitions in that month.*/

-- Gather monthly data for investment rounds between 2010-2013, including the number of US-based funds and acquisitions
WITH 
fundings AS
           (SELECT EXTRACT(MONTH FROM CAST(fr.funded_at AS DATE)) AS funding_month,
            COUNT(DISTINCT f.id) AS us_funds
            FROM fund AS f
            LEFT JOIN investment AS i ON f.id = i.fund_id
            LEFT JOIN funding_round AS fr ON i.funding_round_id = fr.id
            WHERE f.country_code = 'USA'
            AND EXTRACT(YEAR FROM CAST(fr.funded_at AS DATE)) BETWEEN 2010 AND 2013
            GROUP BY funding_month),
acquisitions AS
               (SELECT EXTRACT(MONTH FROM CAST(acquired_at AS DATE)) AS funding_month,
                COUNT(acquired_company_id) AS bought_co,
                SUM(price_amount) AS sum_total
                FROM acquisition
                WHERE EXTRACT(YEAR FROM CAST(acquired_at AS DATE)) BETWEEN 2010 AND 2013
                GROUP BY funding_month)

SELECT fnd.funding_month, fnd.us_funds, acq.bought_co, acq.sum_total
FROM fundings AS fnd
LEFT JOIN acquisitions AS acq ON fnd.funding_month = acq.funding_month;

-- This query calculates the number of US-based funds, acquisitions, and the total acquisition amount for each month in the period between 2010 and 2013.

/* Task 23. Create a pivot table and display the average investment amount for countries with startups registered in 2011, 2012, and 2013. 
   Data for each year should be in a separate field. Sort the table by the average investment value for 2011 in descending order.*/

-- Create a pivot table showing average investment amounts by country for startups founded between 2011-2013
WITH
i AS (SELECT country_code AS country
      FROM company
      WHERE EXTRACT(YEAR FROM founded_at) BETWEEN 2011 AND 2013
      GROUP BY country),
      
y_2011 AS (SELECT country_code AS country, AVG(funding_total) AS avg_fund_2011
           FROM company
           WHERE EXTRACT(YEAR FROM founded_at) = 2011
           GROUP BY country_code),   
           
y_2012 AS (SELECT country_code AS country, AVG(funding_total) AS avg_fund_2012
           FROM company
           WHERE EXTRACT(YEAR FROM founded_at) = 2012
           GROUP BY country_code),           
      
y_2013 AS (SELECT country_code AS country, AVG(funding_total) AS avg_fund_2013
           FROM company
           WHERE EXTRACT(YEAR FROM founded_at) = 2013
           GROUP BY country_code)

-- Retrieve the pivot table showing the average investment amounts per country
SELECT y_2011.country,
       y_2011.avg_fund_2011,
       y_2012.avg_fund_2012,
       y_2013.avg_fund_2013    
FROM y_2011
INNER JOIN y_2012 ON y_2011.country=y_2012.country
INNER JOIN y_2013 ON y_2012.country=y_2013.country

ORDER BY avg_fund_2011 DESC;

-- This query creates a pivot table showing the average funding amounts for startups in each country, based on companies founded between 2011 and 2013. 
-- It displays the data for each year separately.
