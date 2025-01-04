create database bank;

use bank;

CREATE TABLE bank_trans(
	Id TINYINT,
	Amount Decimal(10,2),
	Trans_date DATETIME
);

INSERT INTO bank_trans (Id, Amount, Trans_date) VALUES (1, 500.00, '2024-01-01 10:00:00'), (2, 1500.75, '2024-01-05 14:30:00'), (3, 250.40, '2024-01-10 16:45:00'), (4, 1200.00, '2024-01-15 09:15:00'), (5, 3000.50, '2024-01-20 11:20:00'), (6, 750.25, '2024-01-25 13:00:00'), (7, 950.10, '2024-01-30 15:35:00'), (8, 1750.60, '2024-02-04 10:50:00'), (9, 500.00, '2024-02-10 12:25:00'), (10, 2200.85, '2024-02-14 08:40:00');

SELECT * FROM bank_trans;


--solution 1 

SELECT * FROM bank_trans;

SELECT DISTINCT
	FIRST_VALUE(t1.Trans_Date)
		OVER(PARTITION BY CAST(t1.Trans_Date AS DATE) ORDER BY  t1.Trans_Date DESC) as Transdate,
		FIRST_VALUE(t1.Amount)
			OVER(PARTITION BY CAST(t1.Trans_Date AS DATE) ORDER BY  t1.Trans_Date DESC) as Amount
FROM bank_trans AS t1
order by 1;

