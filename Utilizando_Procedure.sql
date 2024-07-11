/*
Utilizar o aplicativo online: https://www.db-fiddle.com/  (Não consegui utilizar o https://sqliteonline.com/ ) para realizar este teste.
Até consegui gerar a procedure no banco MySQL. Porem quando da criação do tabela ocorre erro na utilização do: AUTO_INCREMENT )

Escolher o banco de dados: MySQL v8.0 - Utilizar o botão RUN para executar

Neste link - video - você ve este comando abaixo comando sendo executado: https://drive.google.com/file/d/1sfXpyqZGoCVp0taQpBn9Jsl_9ajxUYDY/view?usp=sharing

1) Criar a Tabela
2) Povoar
3) Criar a Procedure
5) Executar a Procedure
*/

--Colocar em  SCHEMA SQL (Lado Esquerdo)

DELIMITER //

CREATE TABLE produto (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  item VARCHAR(50) NOT NULL,
  marca VARCHAR (25) NOT NULL,
  dtCompra timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP)//
  
  INSERT INTO produto (item, marca) VALUES
  ('teclado', 'Logitech'),
  ('mouse', 'HP'),
  ('monitor', 'LG'),
  ('mousepad', 'Logitech')//
 
DELIMITER //

CREATE PROCEDURE Vendas_Dia(IN hoje VARCHAR(10))
BEGIN
  SELECT * FROM produto
    WHERE CAST(produto.dtCompra AS DATE) = hoje;
END//

DELIMITER ;


--Utilizar Query SQL (Lado Direito)
CALL Vendas_Dia('2024-07-11');