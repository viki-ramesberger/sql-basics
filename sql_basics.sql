/* ## Task 1. Count how many companies have closed.*/ 

SELECT COUNT(id)
FROM company
WHERE status = 'closed';

/* Task 2. Display the total amount of funds raised by news companies in the USA. Use data from the `company` table. Sort the table in descending order by `funding_total`.*/

SELECT funding_total
FROM company
WHERE category_code = 'news' AND country_code = 'USA'
ORDER BY funding_total DESC;

/* Task 3. Find the total amount of deals where one company acquired another in dollars. Filter the deals that were made exclusively in cash between 2011 and 2013.*/

/* Task 4. Display the first name, last name, and the account names (network_username) of people whose account names start with 'Silver'.*/

/* Task 5. Display all information about people whose account names (network_username) contain the substring 'money' and whose last names start with 'K'.*/

/* Task 6. For each country, display the total amount of investments raised by companies registered in that country. 
The country can be identified by the country code. Sort the data in descending order by the amount.*/


/* Task 7. Create a table showing the date of the funding round, as well as the minimum and maximum investment amounts raised on that date. 
Keep only those records where the minimum investment amount is not zero and not equal to the maximum amount.*/


/* Task 8. Create a category field:
- For funds that invest in 100 or more companies, assign the category high_activity.
- For funds that invest in 20 to 99 companies, assign the category middle_activity.
- For funds that invest in fewer than 20 companies, assign the category low_activity.Display all columns from the fund table along with the new category field.*/

/* Task 9. For each category assigned in the previous task, calculate the average number of investment rounds in which the fund participated, rounded to the nearest integer. 
Display the categories and the average number of rounds, sorting the table in ascending order of the average.*/


/* Task 10. Analyze in which countries the funds that invest the most in startups are located. 
For each country, calculate the minimum, maximum, and average number of companies in which funds from that country invested, based on funds established between 2010 and 2012. 
Exclude countries with funds that have a minimum number of companies receiving investments equal to zero. 
Display the ten most active investor countries, sorted by the average number of companies from highest to lowest. 
Then, add sorting by country code in lexicographical order.*/


/* Task 11. Display the first name and last name of all employees of startups. 
Include a field for the name of the educational institution the employee graduated from, if this information is available.*/


/* Task 12. For each company, find the number of educational institutions its employees graduated from. 
Display the company name and the number of unique educational institutions. 
Create a top-5 list of companies by the number of universities.*/


/* Task 13. */
/* Task 14. */
/* Task 15. */
/* Task 16. */
/* Task 17. */
/* Task 18. */
/* Task 19. */
/* Task 20. */
/* Task 21. */
/* Task 22. */
/* Task 23. */
