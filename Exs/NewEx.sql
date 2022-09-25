USE bd;

ALTER TABLE contas ADD limite double;

DELIMITER $$
CREATE TRIGGER adicionaConta  AFTER INSERT ON clientes FOR EACH ROW BEGIN
  # Variavel para segurar o número
  DECLARE numerao BIGINT;
  SELECT (MAX(numero) + 1) INTO numerao FROM contas; 
  
  # Inserindo valores 
	INSERT INTO contas(numero, tipo, limite, senhan, senhaa, senhaw)
		VALUES(numerao, 2, 200, NEW.pnome, NEW.pnome, NEW.pnome);
        
	INSERT INTO clienteconta(numero, cpf )
		VALUES(numerao, NEW.cpf);
  END $$
DELIMITER ;

/*
	DROP TRIGGER adicionaConta;
*/


# NOVO USUÁRIO
	insert into clientes(cpf, rg, pnome, mnome, unome) Values (1234567891, "1234567891", "Wagner", "SEILA", "AAAA");
    insert into clientes(cpf, rg, pnome, mnome, unome) Values (2312313132, "2313413123", "www", "ccc", "kkk");
    
# VER DADO

SELECT cl.pnome, cc.cpf, cc.numero, co.numero, co.limite FROM clientes cl 
	INNER JOIN clienteconta cc ON cl.cpf = cc.cpf
	INNER JOIN contas co ON cc.numero = co.numero
		WHERE co.limite IS NOT NULL;
	
  
/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ */

# 1 - Poupança
# 2 - Corrente

DELIMITER $$
CREATE TRIGGER criaConta AFTER INSERT ON clientes FOR EACH ROW BEGIN
	 DECLARE numerao BIGINT;
     DECLARE tipao INT;
		SELECT (MAX(numero) + 1) INTO numerao FROM contas;
        SELECT limitaIdade(NEW.nascimento) INTO tipao;
        
    INSERT INTO contas(numero, tipo, senhan, senhaa, senhaw) 
    VALUES(numerao, tipao, NEW.pnome, NEW.pnome, NEW.pnome);
    INSERT INTO clienteconta(numero, cpf )
		VALUES(numerao, NEW.cpf);
END $$
DELIMITER ;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION limitaIdade (nascimento DATE)
	RETURNS INT 
    BEGIN 
		DECLARE idade INT;
        DECLARE tipo INT;
        SELECT TIMESTAMPDIFF(YEAR, nascimento, CURDATE()) INTO idade;
	IF(idade < 18) THEN
		SET tipo = 1;
	ELSE 
		SET tipo = 2;
	END IF;
	
    RETURN tipo;
    
    END $$;
DELIMITER ;

INSERT INTO clientes(cpf, rg, pnome, mnome, unome, nascimento) VALUES (1823845, "3218784", "Wagzinho", "AAAAA", "SOcorro", '2012-01-17');
	
/*
    DROP TRIGGER criaConta;
    DROP FUNCTION limitaIdade;
    
    DELETE FROM clienteconta WHERE numero = 872;
	DELETE FROM contas WHERE numero = 872;
	DELETE FROM clientes WHERE pnome = "Wagzinho";
  
*/ 	

SELECT cl.pnome, cc.cpf, cc.numero, co.tipo FROM clientes cl 
	INNER JOIN clienteconta cc ON cl.cpf = cc.cpf
	INNER JOIN contas co ON cc.numero = co.numero
		WHERE pnome = "Wagzinho";
        
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# O MYSQL NÃO PARECE PODER COLOCAR INSERT, UPDATE e DELETE junto em um TRIGGER. DEUS ESTÁ SEMPRE COM A GENTE


CREATE TABLE cliente_log(
	usuario VARCHAR(255),
    cpf BIGINT,
    rg VARCHAR(255),
    pnome VARCHAR(255),
    mnome VARCHAR(255),
    unome VARCHAR(255),
    nascimento DATE,
    email VARCHAR(255),
    telefone BIGINT,
    endereco VARCHAR(255),
    cidade VARCHAR(255),
    uf CHAR(2),
    cep INT,
    sexo CHAR(1),
    salario DECIMAL(10, 2),
    # --------------------------------
    cpfA BIGINT,
    rgA VARCHAR(255),
    pnomeA VARCHAR(255),
    mnomeA VARCHAR(255),
    unomeA VARCHAR(255),
    nascimentoA DATE,
    emailA VARCHAR(255),
    telefoneA BIGINT,
    enderecoA VARCHAR(255),
    cidadeA VARCHAR(255),
    ufA CHAR(2),
    cepA INT,
    sexoA CHAR(1),
    salarioA DECIMAL(10, 2)
);

DELIMITER $$
CREATE TRIGGER logClienteU AFTER UPDATE ON clientes FOR EACH ROW
	BEGIN
		INSERT INTO cliente_log VALUES(
			CONCAT("ATUALIZADO EM: ", CURDATE(), " as " , hour(now()), ":",minute(now())),
			OLD.cpf,
			OLD.rg,
			OLD.pnome,
			OLD.mnome,
			OLD.unome,
			OLD.nascimento,
			OLD.email,
			OLD.telefone,
			OLD.endereco,
			OLD.cidade,
			OLD.uf,
			OLD.cep,
			OLD.sexo,
			OLD.salario,
            # ----------------------------------
            NEW.cpf,
			NEW.rg,
			NEW.pnome,
			NEW.mnome,
			NEW.unome,
			NEW.nascimento,
			NEW.email,
			NEW.telefone,
			NEW.endereco,
			NEW.cidade,
			NEW.uf,
			NEW.cep,
			NEW.sexo,
			NEW.salario
        );
END $$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER logClienteD AFTER DELETE ON clientes FOR EACH ROW 
	BEGIN
		INSERT INTO cliente_log(usuario, cpf, rg, pnome, mnome, unome, nascimento, email, telefone, endereco, cidade, uf, cep, sexo, salario) VALUES(
			CONCAT("DELETADO EM: ", CURDATE(), " as " , hour(now()), ":",minute(now())),
			OLD.cpf,
			OLD.rg,
			OLD.pnome,
			OLD.mnome,
			OLD.unome,
			OLD.nascimento,
			OLD.email,
			OLD.telefone,
			OLD.endereco,
			OLD.cidade,
			OLD.uf,
			OLD.cep,
			OLD.sexo,
			OLD.salario
            # ----------------------------------
        );
END $$
DELIMITER ;

/*
DROP TRIGGER logClienteU;
DROP TRIGGER logClienteD;
*/

INSERT INTO clientes(cpf, rg, pnome, mnome, unome) VALUES(42821738912, "3128723891", "ME DELETA", "ME DELETA", "ME DELETA"); 

UPDATE clientes SET pnome = "Wagzinho" WHERE pnome = "Wagzinhoo";
SELECT * FROM cliente_log ; 

DELETE FROM clientes WHERE pnome = "ME DELETA";
SELECT * FROM cliente_log ; 




