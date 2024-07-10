CREATE TABLE funcionario (
    autoId SERIAL   NOT NULL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    departamento    INT  NOT NULL,
    salario         DECIMAL  NOT NULL,
    comissao        DECIMAL
);

CREATE TABLE sal_excecao (
    autoId SERIAL NOT NULL PRIMARY KEY,
    funcionario     INT,
    salario_ant     DECIMAL,
    salario_novo    DECIMAL,
	FOREIGN KEY(funcionario)
    REFERENCES funcionario(autoId)
   ON DELETE CASCADE
);

CREATE INDEX idx_funcionario
ON sal_excecao (funcionario);


/*
Este modelo de trigger é utilizado em PL/SQL(Oracle) e tem muita semelhança com o modelo que foi apresentado na JoyClass
Porem este modelo não está funcionando no banco PostgreSQL(https://sqliteonline.com/)
A forma como as trigger são construidas neste banco é diferente(Utiliza-se o conceito de FUNCTION - Aqui o exemplo: https://imasters.com.br/data/triggers-no-postgresql

Sendo que a construção de trigger no SQLite é mais proximas deste modelo, porem tem que fazer alguns ajustes(Vou fazer em outro momento): 
https://www.sqlite.org/lang_createtrigger.html
https://www.sqlitetutorial.net/sqlite-trigger/
*/
CREATE OR REPLACE TRIGGER atualiza_salario
    BEFORE INSERT OR UPDATE ON funcionario
    FOR EACH ROW
BEGIN
    IF (:NEW.departamento = 10 and INSERTING) THEN
        :NEW.comissao := :NEW.salario * .4;
    END IF;

    IF (UPDATING and (:NEW.salario - :OLD.salario) > :OLD.salario * .5) THEN
       INSERT INTO sal_excecao VALUES (:NEW.funcionario, :OLD.salario_ant, :NEW.salario_novo);
    END IF;
END
