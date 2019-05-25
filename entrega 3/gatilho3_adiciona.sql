.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

-- Impede que seja criado um funcionario com menos de 16 anos de idade
CREATE TRIGGER IF NOT EXISTS InsertIdadeValida
BEFORE INSERT ON Funcionario
FOR EACH ROW
WHEN strftime('%J', 'now') - strftime('%J', (SELECT dataNascimento from Pessoa WHERE idPessoa = NEW.idPessoa)) < 5840 -- 16 anos * 365 dias
BEGIN
    SELECT RAISE(ROLLBACK, 'Funcionario necessita de idade superior a 16 anos!');
END;


-- Impede que a data de nascimento de um funcionario seja alterada para valores invalidos
CREATE TRIGGER IF NOT EXISTS UpdateIdadeValida
BEFORE UPDATE OF dataNascimento ON Pessoa
FOR EACH ROW
WHEN (EXISTS (select * from Funcionario where idPessoa = NEW.idPessoa)) AND (strftime('%J', 'now') - strftime('%J', NEW.dataNascimento) < 5840) -- 16 anos * 365 dias
BEGIN
    SELECT RAISE(ROLLBACK, 'Funcionario necessita de idade superior a 16 anos!');
END;