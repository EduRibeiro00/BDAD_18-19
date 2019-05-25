.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Aqui esta a lista de todos os filmes presentes na base de dados, bem como os precos de cada um:'
.print ''

select idFilme, nome, preco from Filme;

.print ''
.print 'Vamos adicionar um novo aluguer, com preco igual a 0 pois ainda nao tem filmes associados:'
.print ''

INSERT INTO Aluguer values(400, '2019-05-05', 0, 71931, 86177, '2019-06-16', NULL);

select * from Aluguer
where idAluguer = 400;

.print ''
.print 'Vamos adicionar o filme 271 ao aluguer:'
.print ''

INSERT INTO AlugFilme values(400, 271);

.print ''
.print 'O preco do aluguer e devidamente atualizado:'
.print ''

select * from Aluguer
where idAluguer = 400;

.print ''
.print 'Vamos adicionar o filme 345 ao aluguer:'
.print ''

INSERT INTO AlugFilme values(400, 345);

.print ''
.print 'O preco do aluguer e devidamente atualizado:'
.print ''

select * from Aluguer
where idAluguer = 400;


.print ''
.print 'Vamos retirar o filme 271 do aluguer:'
.print ''

DELETE FROM AlugFilme
WHERE idAluguer = 400 AND idFilme = 271;

.print ''
.print 'O preco do aluguer e devidamente atualizado:'
.print ''

select * from Aluguer
where idAluguer = 400;

.print ''