-- Impede que seja criado um cliente com menos de 10 anos de idade
CREATE TRIGGER IF NOT EXISTS dataNascValida
BEFORE INSERT ON Cliente
FOR EACH ROW
WHEN strftime('%J', 'now') - strftime('%J', (SELECT dataNascimento from Pessoa WHERE idPessoa = NEW.idPessoa)) < 3650 -- 10 anos * 365 dias
BEGIN
    SELECT RAISE(ROLLBACK, 'Cliente necessita de idade superior a 10 anos!');
END;