.mode columns
.headers on
.nullvalue NULL

/*
create view lucroFilme as
    select idFilme, genero, nome, (preco * count(*)) as lucro
    from AlugFilme natural join Filme
    group by idFilme;

create view filmeMaisLucrativo as
    select genero, nome, idFilme
    from lucroFilme T1
    where lucro = (select max(lucro) from lucroFilme T2 where T1.genero = T2.genero group by genero);




select genero, sum(preco) as sumPreco, avg(preco) as avgPreco, filmeMaisLucrativo.idFilme, filmeMaisLucrativo.nome
from filmeMaisLucrativo join Filme using(genero)
group by genero;


drop view filmeMaisLucrativo;
drop view lucroFilme;
*/

create view lucroFilme as
    select idFilme, genero, nome, (preco * count(*)) as lucro
    from AlugFilme natural join Filme
    group by idFilme;

create view filmeMaisLucrativo as
    select genero, nome, idFilme
    from lucroFilme T1
    where lucro = (select max(lucro) from lucroFilme T2 where T1.genero = T2.genero group by genero);


select genero, sum(preco) as sumPreco, avg(preco) as avgPreco, filmeMaisLucrativo.idFilme, filmeMaisLucrativo.nome
from filmeMaisLucrativo join Filme using(genero)
group by genero;


drop view filmeMaisLucrativo;
drop view lucroFilme;