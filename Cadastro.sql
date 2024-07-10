/*cria a tabela usuario*/
-- CREATE TABLE usuario (
-- autoId SERIAL NOT NULL PRIMARY KEY,
-- nome VARCHAR(100) NOT NULL ,
-- cpf INT NULL ,
-- rg VARCHAR(20) NULL ,
-- genero CHAR(1) NOT NULL ,
-- whatsapp VARCHAR(14) NULL ,
-- login VARCHAR(15) NOT NULL ,
-- senha VARCHAR(15) NOT NULL ,
-- nivel INT NOT NULL ,
-- cadastro TIMESTAMP NOT NULL,
-- situacao BOOL NOT NULL);

-- /*
-- Alterar o domínio do atributo CPF de INT para BIGINT
-- Só descobri este pequeno detalhe quando da inclusão dos usuarios
-- Tipos de Dados: https://www.devmedia.com.br/tipos-de-dados-no-postgresql-e-sql-server/23362
-- */
-- ALTER TABLE usuario
    -- ALTER COLUMN cpf TYPE BIGINT;

-- /*Cria índice ÚNICO para o CPF - Portanto CPF passa a ser o identificador externo do cadastro de Usuario*/
-- CREATE UNIQUE INDEX usuario_cpf_idx ON usuario (cpf);

-- /*
-- Gerador de CPF online: https://www.4devs.com.br/gerador_de_cpf
-- Gerador de TIMESTAMP online: https://timestampgenerator.com/1720633379/+00:00
-- */

-- /* Povoamento da Tabela Usuario*/
-- INSERT INTO usuario (nome, cpf, rg, genero, whatsapp, login, senha, nivel, cadastro, situacao) VALUES
  -- ('Antonio da Silva Santos', 00421264012, 'MG-4.001.999', 'M', '31999999999', 'meu_Login', 'minha_Senha', 1, '2024-07-10 17:42:59', true),
  -- ('Maria Jose de Paula Santos', 12335383060, 'MG-4.002.999', 'F', '31999999999', 'meu_Login2', 'minha_Senha2', 1, '2024-07-10 17:43:00', true),
  -- ('Pedro Antonio Paula dos Santos', 42248600070, 'MG-4.003.999', 'M', '31999999999', 'meu_Login3', 'minha_Senha3', 1, '2024-07-10 17:43:01', true),
  -- ('Regina Paula dos Santos', 61348345055, 'MG-4.004.999', 'F', '31999999999', 'meu_Login4', 'minha_Senha4', 1, '2024-07-10 17:43:02', true),
  -- ('Guilherme Henrique Paula da Silva Santos', 97301313098, 'MG-4.005.999', 'M', '31999999999', 'meu_Login5', 'minha_Senha5', 1, '2024-07-10 17:43:03', true);

-- /*Cria a tabela endereco*/
 -- CREATE TABLE endereco (
-- autoId SERIAL NOT NULL PRIMARY KEY,
-- usuario INT NOT NULL ,
-- tipo VARCHAR(10) NULL ,
-- cep VARCHAR(10) NULL ,
-- rua VARCHAR(100) NULL ,
-- numero VARCHAR(10) NULL ,
-- bairro VARCHAR(30) NULL ,
-- complemento VARCHAR(20) NULL ,
-- cidade VARCHAR(50) NULL ,
-- uf CHAR(2) NULL ,
-- situacao BOOL NULL ,
-- FOREIGN KEY(usuario)
-- REFERENCES usuario(autoId)
-- ON DELETE CASCADE);

-- /*Cria indice para o atributo(coluna) usuario*/
-- CREATE INDEX idx_usuario
-- ON endereco (usuario);

-- /*
-- Povoamento da tabela endereço onde o atributo Usuario é gerado tendo como referência o atributo AutoId da tabela Usuario
-- */
-- INSERT INTO endereco (usuario, tipo, cep, rua, numero, bairro, complemento, cidade, uf, situacao) VALUES(
-- (SELECT autoId FROM usuario where cpf = 421264012),
-- 'RUA', '30500280', 'CORONEL ANTONIO PEDRO','150','CENTRO','CASA','BELO HORIZONTE','MG',TRUE);

-- INSERT INTO endereco (usuario, tipo, cep, rua, numero, bairro, complemento, cidade, uf, situacao) VALUES(
-- (SELECT autoId FROM usuario where cpf = 12335383060),
-- 'RUA', '30500280', 'CORONEL ANTONIO PEDRO','150','CENTRO','CASA','BELO HORIZONTE','MG',TRUE);

-- INSERT INTO endereco (usuario, tipo, cep, rua, numero, bairro, complemento, cidade, uf, situacao) VALUES(
-- (SELECT autoId FROM usuario where cpf = 42248600070),
-- 'RUA', '30500280', 'CORONEL ANTONIO PEDRO','150','CENTRO','CASA','BELO HORIZONTE','MG',TRUE);

-- INSERT INTO endereco (usuario, tipo, cep, rua, numero, bairro, complemento, cidade, uf, situacao) VALUES(
-- (SELECT autoId FROM usuario where cpf = 61348345055),
-- 'RUA', '30500280', 'CORONEL ANTONIO PEDRO','150','CENTRO','CASA','BELO HORIZONTE','MG',TRUE);

-- INSERT INTO endereco (usuario, tipo, cep, rua, numero, bairro, complemento, cidade, uf, situacao) VALUES(
-- (SELECT autoId FROM usuario where cpf = 97301313098),
-- 'RUA', '30500280', 'CORONEL ANTONIO PEDRO','150','CENTRO','CASA','BELO HORIZONTE','MG',TRUE);


-- SELECT * FROM usuario;
-- SELECT * FROM endereco;

-- SELECT * FROM usuario AS U
-- RIGHT JOIN endereco AS E ON E.usuario = U.autoid;
