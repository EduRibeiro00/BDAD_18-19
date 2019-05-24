--Impede que seja criado u cliente com menos de 10 anos de idade
CREATE TRIGGER IF NOT EXISTS trigger3
BEFORE INSERT ON Cliente
FOR EACH ROW
WHEN strftime('%J', 'now') - strftime('%J', (SELECT dataNascimento from Pessoa WHERE idPessoa = NEW.idPessoa)) < 3650
BEGIN
    SELECT RAISE(ABORT, 'Necessita de idade superior a 10 anos');
END;