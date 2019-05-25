.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

INSERT INTO Aluguer values (300, '2019-01-01', NULL, 71231, 80876, '2019-02-02', NULL);

.print ''
.print 'Foi introduzido o seguinte aluguer:'
.print ''

select idAluguer, idLoja, idCliente
from Aluguer
where idAluguer = 300;

.print ''
.print 'A loja no qual o aluguer foi registado tem os seguintes filmes:'
.print ''

select idLoja, idFilme, nome, numExemplares
from Stock natural join Filme
where idLoja = 71231;

.print ''
.print 'Vamos tentar adicionar o filme 216 ao aluguer:'
.print ''

INSERT INTO AlugFilme values (300, 216);

.print ''
.print 'Estado atual dos filmes na loja:'
.print 'Como se pode observar, o numero de exemplares do filme diminiu em 1.'
.print ''

select idLoja, idFilme, nome, numExemplares
from Stock natural join Filme
where idLoja = 71231;

.print ''
.print 'Vamos tentar adicionar o filme 213 ao aluguer:'
.print ''

INSERT INTO AlugFilme values (300, 213);

.print ''
.print 'Estado atual dos filmes na loja:'
.print 'Como se pode observar, a loja ja nao tem mais exemplares desse filme.'
.print ''

select idLoja, idFilme, nome, numExemplares
from Stock natural join Filme
where idLoja = 71231;

.print ''
.print 'Vamos tentar adicionar o filme 345 ao aluguer:'
.print ''

INSERT INTO AlugFilme values (300, 345);

.print ''
.print 'Podemos confirmar que o filme nao foi adicionado ao aluguer:'
.print ''

select * 
from AlugFilme
where idAluguer = 300; 