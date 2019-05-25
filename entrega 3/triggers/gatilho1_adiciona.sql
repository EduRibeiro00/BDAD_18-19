.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

-- Ao adicionar um filme a um aluguer, retira do stock da loja (se stock maior que 1)
CREATE TRIGGER IF NOT EXISTS updateStockLojaAluguer
AFTER INSERT ON AlugFilme
FOR EACH ROW
WHEN (select numExemplares from Stock 
      where idFilme = NEW.idFilme AND
      idLoja = (select idLoja from Aluguer
                where idAluguer = NEW.idAluguer)) > 1
BEGIN
    UPDATE Stock
    SET numExemplares = numExemplares - 1
    WHERE (idFilme = NEW.idFilme AND
      idLoja = (select idLoja from Aluguer
                where idAluguer = NEW.idAluguer));
END;



-- Ao adicionar um filme a um aluguer, retira do stock da loja (se stock igual a 1)
CREATE TRIGGER IF NOT EXISTS removeStockLojaAluguer
AFTER INSERT ON AlugFilme
FOR EACH ROW
WHEN (select numExemplares from Stock 
      where idFilme = NEW.idFilme AND
      idLoja = (select idLoja from Aluguer
                where idAluguer = NEW.idAluguer)) == 1
BEGIN
    DELETE FROM Stock
    WHERE (idFilme = NEW.idFilme AND
      idLoja = (select idLoja from Aluguer
                where idAluguer = NEW.idAluguer));
END;



-- Verifica, quando se adiciona um filme a um aluguer, se esse filme esta disponivel na loja
CREATE TRIGGER IF NOT EXISTS checkStockLojaAluguer
BEFORE INSERT ON AlugFilme
FOR EACH ROW
WHEN NOT EXISTS (select * from Stock 
      where (idFilme = NEW.idFilme AND
      idLoja = (select idLoja from Aluguer
                where idAluguer = NEW.idAluguer)))
BEGIN
    SELECT RAISE(ROLLBACK, 'O filme esta indisponivel na loja!');
END;
