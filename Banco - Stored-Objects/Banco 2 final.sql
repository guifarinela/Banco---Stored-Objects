/* mostrar o nome do autor e seu respectivo ID*/

USE atividade4;

SELECT *
  FROM leitores;

CREATE VIEW nomeLeitor AS
	 SELECT leitor_id, nome_leitor 
	   FROM leitores;

	SELECT *
        FROM nomeLeitor
    GROUP BY leitores;
    
    /* criada uma função que irá retirar '.' e colocar ',' */
    DELIMITER $$
    CREATE FUNCTION removePontuacao(TEXTO CHAR(50))
    RETURNS CHAR (50)
           BEGIN
			 SET TEXTO = REPLACE (TEXTO,'.', ',');
          RETURN TEXTO;
	END;
    $$
    
/* Criada uma procedure para ver o titulo de um livro pelo ID */

DELIMITER $$
CREATE PROCEDURE tituloLivro(Questao VARCHAR(100))
SELECT CONCAT('O nome é ', titulo_livro) AS livro
FROM livros
WHERE livro_id = Questao;
$$

CALL tituloLivro(5);

/* Criada uma trigger para que toda vez que alguem inserir o titulo de um livro, adicionar o nome da produtora junto */

DELIMITER //

CREATE TRIGGER nomeLivro BEFORE INSERT
ON livros
FOR EACH ROW 
SET new.titulo_livro = (new.titulo_livro + 'editora');

INSERT INTO livros (titulo_livro)
VALUES ('Harry Potter');
END //

DELIMITER ;

SELECT *
  FROM livros;
  
/* Criado um event para que a cada 1 hora limpe as informações da tabela leitura */

DROP EVENT IF EXISTS leituraLimpa;

DELIMITER $$
CREATE EVENT leituraLimpa
ON SCHEDULE EVERY 1 HOUR
    COMMENT 'Limpa a tabela de sessões a cada hora.'
    DO
      DELETE FROM leitura;
END $$

DELIMITER ;

  