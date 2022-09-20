/* 1- Select clients' cities */
DESCRIBE clientes;
SELECT pnome, cidade FROM clientes;

/* 2- Show sellers from 5º to 10º position */
DESCRIBE gerentes;
SELECT * from gerentes; /* Select all */
SELECT * FROM gerentes limit 6 offset 4; /* From 5º to 10º position */

/* 3- Show all transitions with values between -100 and 100*/
DESCRIBE transacoes;
SELECT * FROM transacoes;
SELECT * FROM transacoes WHERE
	valor BETWEEN -100 and 100;

/* 4- Show all sellers from 5º to 10º position in alphabetical order */
DESCRIBE gerentes;
SELECT * FROM gerentes order by pnome ASC limit 6 offset 4; /* From 5º to 10º position */

/* 5- Show first five sellers with biggest salary */
DESCRIBE gerentes;
SELECT * FROM gerentes order by salario DESC limit 5;

/* -- STRING MANIPULATION -- */

/* 1- Select all clients that have the substring "an" in the START of first name */
SELECT * FROM clientes WHERE pnome LIKE "an%";

/* 2- Select all clients that have the substring "an" in the END of first name */
SELECT * FROM clientes WHERE pnome LIKE "%an";

/* 3- Select all clients that have the substring "an" in first name */
SELECT * FROM clientes WHERE pnome LIKE "%an%";

/* 4- Select all clients that have the substring "an" in the START of first name followed any character followed by "o" followed by anything */
SELECT * FROM clientes ORDER BY pnome;
SELECT * FROM clientes WHERE pnome LIKE "an_o%";

/* 5- Select all transactions that has the character "%" in note */
DESCRIBE transacoes;
SELECT * FROM transacoes WHERE observacao LIKE "%";

/* -- CONCAT -- */
/* 1- Show clients complete name */
SELECT concat(pnome," ",mnome," ",unome) as fullname FROM clientes;

/* 2- Show clients full name with a Merry Christmas message */
SELECT concat(pnome," ",mnome," ",unome, " ,MERRY CHRISTMAS!") as message FROM clientes;

/* 3- Show full address of clients */
DESCRIBE clientes;
SELECT pnome, concat(
endereco, ", ",
cidade, ", ",
uf, ", ",
cep) as address FROM clientes; 

/* -- Date and Time -- */