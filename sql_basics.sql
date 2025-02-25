/* Task 1. Count how many companies have closed.*/ 

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

/* Task 6. For each country, display the total amount of investments raised by companies registered in that country. The country can be identified by the country code. Sort the data in descending order by the amount.*/
/* Task 7. Create a table showing the date of the funding round, as well as the minimum and maximum investment amounts raised on that date. Keep only those records where the minimum investment amount is not zero and not equal to the maximum amount.*/
/* Task 8. */
/* Task 9. */
/* Task 10. */
/* Task 11. */
/* Task 12. */
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
