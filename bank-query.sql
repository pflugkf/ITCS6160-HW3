#Question 1
SELECT COUNT(type) AS total_deposits FROM transaction WHERE type = 'Deposit';

#Question 2
SELECT * FROM transaction 
WHERE account_num = '1111222233331441' AND tdate LIKE '2019-09-__';

#Question 3
SELECT amount FROM transaction 
WHERE account_num = '1111222233331441' AND tdate < '2019-09-01';

#Question 4
SELECT name, amount FROM transaction 
JOIN account ON transaction.account_num = account.number
JOIN customer ON account.owner_ssn = customer.ssn
WHERE amount = (SELECT MAX(amount) FROM transaction);

#Question 5
SELECT name FROM customer WHERE sex = 'M' 
AND ssn IN (SELECT owner_ssn FROM account WHERE type = 'Checking');

#Question 6
SELECT number, type FROM account 
WHERE owner_ssn = (SELECT ssn FROM customer WHERE name = 'Alexander Felix');

#Question 7
SELECT account.number, account.type, SUM(amount) AS Balance FROM transaction
JOIN account ON transaction.account_num = account.number
WHERE account_num = (SELECT number FROM account 
WHERE owner_ssn = (SELECT ssn FROM customer WHERE name = 'Alexander Felix')
AND type = 'Checking')
GROUP BY account.number
UNION
SELECT account.number, account.type, SUM(amount) AS Balance FROM transaction
JOIN account ON transaction.account_num = account.number
WHERE account_num = (SELECT number FROM account 
WHERE owner_ssn = (SELECT ssn FROM customer WHERE name = 'Alexander Felix')
AND type = 'Saving')
GROUP BY account.number;

#Question 8a
SELECT name FROM customer WHERE ssn IN 
(SELECT owner_ssn FROM account WHERE number IN 
(SELECT account_num FROM transaction WHERE amount >= 1000));

#Question 8b
SELECT name FROM transaction 
JOIN account ON transaction.account_num = account.number
JOIN customer ON account.owner_ssn = customer.ssn
WHERE amount >= 1000;

#Question 9
SELECT name, COUNT(account_num)
FROM (SELECT * FROM transaction WHERE type = 'Deposit') AS deposits
JOIN account ON deposits.account_num = account.number
JOIN customer ON account.owner_ssn = customer.ssn
GROUP BY name
HAVING COUNT(account_num) >= 2;
