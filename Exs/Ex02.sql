USE bd;

/* -- VIEWS -- */

# 1 - Create a view that contains account number, cpf, name, birth date and approximate age of all clients
CREATE VIEW clientInfo AS 
	SELECT cc.numero, c.cpf, c.pnome, c.nascimento , TIMESTAMPDIFF(YEAR, nascimento, CURDATE()) as age
		FROM clienteconta cc INNER JOIN clientes c 
        ON cc.cpf = c.cpf ;
        
     # DROP VIEW clientInfo;
        SELECT * FROM clientInfo;

# 2 - Create a view that contains account number, client cpf, and all transactions released by them
CREATE VIEW clientTransactions AS
	SELECT cc.numero, c.cpf, tc.numerot as transactions
		FROM clienteconta cc INNER JOIN clientes c ON cc.cpf = c.cpf
        INNER JOIN transacaoconta tc ON tc.numeroc = cc.numero;

	# SELECT * FROM transacaoconta;
	# DROP VIEW clientTransactions;
		SELECT * FROM clientTransactions;
        
# 3 - Create a view that contains account number, account type, transaction type, biggest transaction value and lowest transaction values
CREATE VIEW accountTransaction AS
	SELECT tc.numeroc, c.tipo, t.tipo as transactionType, MAX(t.valor), MIN(t.valor) 
		FROM transacaoconta tc INNER JOIN contas c
        ON tc.numeroc = c.numero
        INNER JOIN transacoes t  ON tc.numerot = t.numero;
        
        # DROP VIEW accountTransaction;
			SELECT * FROM accountTransaction;

# 4 - Alter the value of a transaction and verify if it's reflects the view
CREATE VIEW showTransactions AS
	SELECT t.numero, t.valor FROM transacoes t WHERE t.numero <= 10;
    
    # DROP VIEW showTransactions;
		UPDATE transacoes SET valor = 200.00 WHERE numero = 1;
		SELECT * FROM showTransactions;
        
/* -- SUB-SELECTS -- */

# 1 - Show the manager full name of the client which cpf is 11227342015
SELECT CONCAT(pnome, " ", mnome, " ", unome) as fullname FROM gerentes g
	WHERE registro IN(
		SELECT registro FROM clientegerente cg WHERE cg.cpf = 11227342014);

# 2 - Show the oldest clients
SELECT pnome, TIMESTAMPDIFF(YEAR, nascimento, CURDATE()) as age FROM clientes
	ORDER BY TIMESTAMPDIFF(YEAR, nascimento, CURDATE()) DESC LIMIT 10; 
    
# 3 - Select transaction value number of credits released in 2020
SELECT t.numero, t.valor, Year(tc.tdata) 
	FROM transacoes t INNER JOIN transacaoconta tc 
    ON t.numero = tc.numerot
	WHERE t.abreviacao = 'CMP' AND YEAR(tc.tdata) = '2020';

# 4 - Save all past consults in a table called history2020

/* -- Agrupments --*/

# 1 -
	SELECT uf, COUNT(pnome) FROM clientes GROUP BY uf HAVING COUNT(uf) = (
		SELECT COUNT(uf) FROM clientes
			GROUP BY uf ORDER BY COUNT(uf) DESC LIMIT 1);
		
# 2 - 
    SELECT sexo, AVG(TIMESTAMPDIFF(YEAR, nascimento, CURDATE())) FROM clientes WHERE TIMESTAMPDIFF(YEAR, nascimento, CURDATE()) > 30 GROUP BY sexo;

# 3 -
	SELECT 	tipo, COUNT(valor) as TotalValue, AVG(valor) FROM transacoes GROUP BY tipo;

# 4 - 
	SELECT * FROM agencias;
    SELECT * FROM agenciaconta ;
    
    SELECT a.numero, a.nome, COUNT(ac.numeroc) FROM agencias a INNER JOIN agenciaconta ac 
		ON a.numero = ac.numeroa GROUP BY ac.numeroa;

# 5 - 
	SELECT a.nome, ac.numeroa, SUM(t.valor) FROM agencias a INNER JOIN agenciaconta ac ON a.numero = ac.numeroa 
		INNER JOIN transacaoconta tc ON ac.numeroc = tc.numeroc
		INNER JOIN transacoes t ON tc.numerot = t.numero 
			WHERE t.tipo = 1
				GROUP BY ac.numeroa HAVING SUM(t.valor) > 1300000;
		