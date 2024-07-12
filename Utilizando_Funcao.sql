/*
Utilizar o aplicativo online: https://www.db-fiddle.com/

ATENÇÃO: para montar este caso de teste deu trabalho devido à forma com que uma função é criada no banco MySQL, bem como os erros que ocorreram.
Consultar:
https://stackoverflow.com/questions/7946553/deterministic-function-in-mysql
https://dev.mysql.com/doc/refman/8.4/en/create-procedure.html

Escolher o banco de dados: MySQL v8.0 - Utilizar o botão RUN para executar

Neste link - video - você ve como executar este script: https://drive.google.com/file/d/1sfXpyqZGoCVp0taQpBn9Jsl_9ajxUYDY/view?usp=sharing
Observacao: este vídeo é de outro exercício mas serve como modelo para este

Gerador de CPF online: https://www.4devs.com.br/gerador_de_cpf

1) Criar a Tabela
2) Povoar
3) Criar a Fumção
5) Executar a Função

Esta função tem como objetivo identificar todas as vendas realizadas em uma data e associar estas vendas com o cadastro de cliente cuja data de inclusão corresponda à data da venda.


--Colocar em SCHEMA SQL (Lado Esquerdo)

Estou utilizando a tabela: DUAL (Para mais detalhes: https://www.devmedia.com.br/tabela-dual-do-oracle/17218
A tabela dual, também conhecida como tabela dummy, é uma tabela nativa do Oracle que contém apenas uma linha e uma coluna e é utilizada como uma tabela fictícia. A tabela dual é utilizada para suprir necessidades sintáticas em funções nativas e comandos que necessitam uma seleção. Também é utilizada para fazer operações com select aonde não é necessário fazer extração de dados em tabelas.
O MySQL também contempla este tipo de tabela.
Você pode utilziar esta tabela para fazer calculo: SELECT 1+5 FROM DUAL
*/

DELIMITER //

CREATE TABLE cliente (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(30) not NULL,
  cpf LONG not NULL, 
  uf VARCHAR(2),
  dtCadastro timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP)//

INSERT INTO cliente (nome, cpf, uf) VALUES
  ('João Alves', 421264012, 'MG'),
  ('RobertoGarcia', 12335383060, 'RJ'),
  ('Dario Rubens', 42248600070, 'SP'),
  ('Julia Lopes', 61348345055, 'ES'),
  ('Rebeca Giglio', 97301313098, 'RS')//

CREATE TABLE produto (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  item VARCHAR(50) NOT NULL,
  marca VARCHAR (25) NOT NULL)//
  
INSERT INTO produto (item, marca) VALUES
  ('teclado', 'Logitech'),
  ('mouse', 'HP'),
  ('monitor', 'LG'),
  ('mousepad', 'Logitech')//
  
CREATE TABLE venda (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cliente INT NOT NULL,
  produto INT NOT NULL,
  qtde INT NOT NULL,
  dtVenda timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_cliente FOREIGN KEY (cliente) REFERENCES cliente(id),
  CONSTRAINT fk_produto FOREIGN KEY (produto) REFERENCES produto(id))//

INSERT INTO venda (cliente, produto, qtde) VALUES
  ((SELECT id FROM cliente WHERE cpf = 421264012),   (SELECT id FROM produto WHERE item = 'mousepad'), 200),
  ((SELECT id FROM cliente WHERE cpf = 12335383060), (SELECT id FROM produto WHERE item = 'mousepad'), 800),
  ((SELECT id FROM cliente WHERE cpf = 42248600070), (SELECT id FROM produto WHERE item = 'monitor'), 100),
  ((SELECT id FROM cliente WHERE cpf = 61348345055), (SELECT id FROM produto WHERE item = 'teclado'), 400),
  ((SELECT id FROM cliente WHERE cpf = 97301313098), (SELECT id FROM produto WHERE item = 'mouse'), 1200)//
  
DELIMITER //

CREATE FUNCTION Qtde_Clientes_Venda(hoje VARCHAR(10))
 RETURNS INT(10) DETERMINISTIC

BEGIN 
 DECLARE qtdeClientes INT;
 
  SELECT COUNT(*) INTO qtdeClientes FROM venda V
    INNER JOIN cliente AS C ON C.id = V.cliente
    WHERE CAST(V.dtVenda AS DATE) = hoje AND (V.dtVenda = C.dtCadastro)
	GROUP BY V.dtVenda;
	RETURN qtdeClientes;
END//

DELIMITER ;


--Utilizar Query SQL (Lado Direito)
SELECT Qtde_Clientes_Venda('2024-07-12') AS Qtde_Clientes_Hoje FROM DUAL;