USE bd;

# 1- Select clients' cities
DESCRIBE clientes;
SELECT pnome, cidade FROM clientes;

# 2- Show sellers from 5º to 10º position 
DESCRIBE gerentes;
SELECT * from gerentes; /* Select all */
SELECT * FROM gerentes limit 6 offset 4; /* From 5º to 10º position */

# 3- Show all transitions with values between -100 and 100
DESCRIBE transacoes;
SELECT * FROM transacoes;
SELECT * FROM transacoes WHERE
	valor BETWEEN -100 and 100;

# 4- Show all sellers from 5º to 10º position in alphabetical order
DESCRIBE gerentes;
SELECT * FROM gerentes order by pnome ASC limit 6 offset 4; /* From 5º to 10º position */

# 5- Show first five sellers with biggest salary 
DESCRIBE gerentes;
SELECT * FROM gerentes order by salario DESC limit 5;

/* -- STRING MANIPULATION -- */

# 1- Select all clients that have the substring "an" in the START of first name 
SELECT * FROM clientes WHERE pnome LIKE "an%";

# 2- Select all clients that have the substring "an" in the END of first name 
SELECT * FROM clientes WHERE pnome LIKE "%an";

# 3- Select all clients that have the substring "an" in first name 
SELECT * FROM clientes WHERE pnome LIKE "%an%";

# 4- Select all clients that have the substring "an" in the START of first name followed any character followed by "o" followed by anything 
SELECT * FROM clientes ORDER BY pnome;
SELECT * FROM clientes WHERE pnome LIKE "an_o%";

# 5- Select all transactions that has the character "%" in note 
DESCRIBE transacoes;
SELECT * FROM transacoes WHERE observacao LIKE "%";

/* -- CONCAT -- */

# 1- Show clients complete name 
SELECT concat(pnome," ",mnome," ",unome) as fullname FROM clientes;

# 2- Show clients full name with a Merry Christmas message 
SELECT concat(pnome," ",mnome," ",unome, " ,MERRY CHRISTMAS!") as message FROM clientes;

# 3- Show full address of clients 
DESCRIBE clientes;
SELECT pnome, concat(
endereco, ", ",
cidade, ", ",
uf, ", ",
cep) as address FROM clientes; 

/* -- Date and Time -- */

# 1 -Show information about day, month, year, hour, minute and seconds of transactions occurred
SELECT numeroc, DAY(tdata), MONTH(tdata), YEAR(tdata), HOUR(tdata), MINUTE(tdata), SECOND(tdata) FROM transacaoconta;

# 2 - Show date of admission of employes in format dd/mm/yy
SELECT * FROM gerentes;
SELECT registro, pnome, CONCAT(DAY(admissao), "/", MONTH(admissao), "/", YEAR(admissao)) as data_admissao FROM gerentes;

# 3 - Show full name, text "born in" and the birth date in format day of month of year of clients
SELECT * FROM clientes;
SELECT CONCAT(pnome, " ", mnome, " ", unome) as fullname, CONCAT("Born in ", DAY(nascimento), " of ", MONTH(nascimento), " of ", YEAR(nascimento)) as birth_day FROM clientes;

# 4 - Show birth date of 5 first clients added 2 years
SELECT pnome, nascimento FROM clientes;
SELECT pnome, ADDDATE(nascimento, INTERVAL 1 YEAR) as birthDate_plus2Y FROM clientes;

# 5 - Show birth date of 5 first clients added 5 months
SELECT pnome, nascimento FROM clientes;
SELECT pnome, ADDDATE(nascimento, INTERVAL 5 MONTH) as birthDate_plus5M FROM clientes;

# 6 - Show birth date of 5 first clientes added 20 days
SELECT pnome, nascimento FROM clientes;
SELECT pnome, ADDDATE(nascimento, INTERVAL 20 DAY) as birthDate_plus20D FROM clientes;

# 7 - Show transaction date added 1 hour, 5 minutes and 10 seconds
SELECT numeroc, tdata FROM transacaoconta;
SELECT numeroc, tdata + INTERVAL 1 HOUR + INTERVAL 5 MINUTE + INTERVAL 10 SECOND as sa FROM transacaoconta;

# 8 - Show managers that will complete 30 years after date 01/08/2022
SELECT pnome, TIMESTAMPDIFF(YEAR, nascimento, '2022-08-01') AS age FROM gerentes;
SELECT pnome, nascimento, TIMESTAMPDIFF(YEAR, nascimento,'2022-08-01') AS age FROM gerentes
	WHERE TIMESTAMPDIFF(YEAR, nascimento, CURDATE())  > 30;

# 9 - Show all clients with more than 50 years
SELECT pnome, TIMESTAMPDIFF(YEAR, nascimento, CURDATE()) as current_age FROM clientes 
	WHERE TIMESTAMPDIFF(YEAR, nascimento, CURDATE()) > 50;

# 10 - Show all managers that has less than 15 years and 6 months of contract
SELECT pnome, admissao, CONCAT(TIMESTAMPDIFF(YEAR, admissao, CURDATE()), "-",
    TIMESTAMPDIFF(MONTH, admissao, CURDATE()) DIV 30) as contract FROM gerentes;
    
SELECT pnome, admissao, CONCAT(
	TIMESTAMPDIFF(YEAR, admissao, CURDATE()), "-",
    TIMESTAMPDIFF(MONTH, admissao, CURDATE()) DIV 30) as contract
		FROM gerentes
			WHERE TIMESTAMPDIFF(YEAR, admissao, CURDATE()) <= 15 AND
             TIMESTAMPDIFF(MONTH, admissao, CURDATE()) < 183;
             
# 11 - Show transactions released at least 5 months and not more than 1 year              
SELECT * FROM transacaoconta;
SELECT numeroc, tdata, TIMESTAMPDIFF(MONTH, tdata, CURDATE()) as realeazed FROM transacaoconta
	WHERE TIMESTAMPDIFF(MONTH, tdata, CURDATE()) >= 5 AND TIMESTAMPDIFF(MONTH, tdata, CURDATE()) < 12 ;
	
# -- Aggregation Functions

# 1 - Show the amount of transactions that were deposited
SELECT COUNT(abreviacao) FROM transacoes  WHERE abreviacao = "DEP";

# 2 - Show the salary sum of managers that are not from Minas Gerais
SELECT * FROM gerentes;
SELECT SUM(salario) FROM gerentes WHERE uf != "MG";

# 3 - Show the amount of transactions released in 2021 January
SELECT * FROM transacaoconta;
SELECT COUNT(numerot) FROM transacaoconta WHERE EXTRACT(YEAR_MONTH FROM tdata) = EXTRACT(YEAR_MONTH FROM '2021-01-01'); # -- NOT SURE THIS

# 4 - Show name and the biggest birth date of clients from SÃO PAULO
SELECT * FROM clientes;
SELECT pnome, nascimento FROM clientes WHERE YEAR(nascimento) < 1980 AND uf = "SP"; # --

# 5 - Show lower salaries of managers admitted after 2000
SELECT * FROM gerentes;
SELECT pnome, salario FROM gerentes WHERE YEAR(admissao) > 2000 AND AVG(salario) > salario;

SELECT YEAR('2022-02-02');
SELECT AVG(salario)FROM gerentes;

/* -- FUNCTIONS -- */
