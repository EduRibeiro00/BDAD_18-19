.mode columns
.headers on
.nullvalue NULL

-- contem o lucro de cada filme
create view auxFilmeLucro as
    select idFilme, genero, nome, (preco * count(*)) as lucro
    from AlugFilme natural join Filme
    group by idFilme;

-- contem os valores de lucro total e lucro medio para cada genero
create view auxStatsGenero as
    select genero, sum(lucro) as sumLucro, avg(lucro) as avgLucro
    from auxFilmeLucro
    group by genero;


select genero, sumLucro, avgLucro, idFilme, nome
from auxFilmeLucro natural join auxStatsGenero as T1
where lucro = (
    select max(T2.lucro) 
    from auxFilmeLucro as T2
    where T1.genero = T2.genero
)
group by idFilme;

drop view auxStatsGenero;
drop view auxFilmeLucro;