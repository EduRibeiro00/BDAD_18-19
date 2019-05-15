.mode columns
.headers on
.nullvalue NULL

create view auxAlugCount as
    select idFilme, genero, nome, preco, count(*) as numAlugueres
    from AlugFilme natural join Filme
    group by idFilme;

create view filmeMaisLucrativo as
    select genero, nome, idFilme, max(preco * numAlugueres) as lucroFilme
    from auxAlugCount
    group by genero;


select genero, sum(preco) as sumPreco, avg(preco) as avgPreco, filmeMaisLucrativo.idFilme, filmeMaisLucrativo.nome
from filmeMaisLucrativo join Filme using(genero)
group by genero;


drop view filmeMaisLucrativo;
drop view auxAlugCount;