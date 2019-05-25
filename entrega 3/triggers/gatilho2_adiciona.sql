.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

-- ao adicionar um filme a um aluguer, o preco do filme e acrescentado ao aluguer
CREATE TRIGGER IF NOT EXISTS adicionaPrecoAluguer
AFTER INSERT ON AlugFilme
FOR EACH ROW
BEGIN
    UPDATE Aluguer
    SET precoAluguer = precoAluguer + (select preco from AlugFilme natural join Filme where idFilme = new.idFilme)
    WHERE idAluguer = new.idAluguer;
END;


-- ao remover um filme de um aluguer, o preco do filme e retirado ao aluguer
CREATE TRIGGER IF NOT EXISTS retiraPrecoAluguer
AFTER DELETE ON AlugFilme
FOR EACH ROW
BEGIN
    UPDATE Aluguer
    SET precoAluguer = precoAluguer - (select preco from AlugFilme natural join Filme where idFilme = old.idFilme)
    WHERE idAluguer = old.idAluguer;
END;
