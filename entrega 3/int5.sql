.mode columns
.headers on
.nullvalue NULL

create view auxAlugCount as
    select Filme.nome, count(*) NumAlugueres
    from AlugFilme, Aluguer, Filme
    where AlugFilme.idAluguer = Aluguer.idAluguer
    and AlugFilme.idFilme = Filme.idFilme
    group by Filme.nome;

create view auxGeneroFilmeLucrativo as
    select Filme.genero, Filme.nome NomeFilme, Filme.idFilme, max(Filme.preco * auxAlugCount.NumAlugueres) LucroFilme
    from auxAlugCount, Filme
    where Filme.nome = auxAlugCount.nome
    group by Filme.genero;


select Filme.genero, sum(preco) SumPreco, avg(preco) AvgPreco, auxGeneroFilmeLucrativo.idFilme, auxGeneroFilmeLucrativo.NomeFilme
from auxGeneroFilmeLucrativo, Filme
where Filme.genero = auxGeneroFilmeLucrativo.genero
group by Filme.genero;


drop view auxGeneroFilmeLucrativo;
drop view auxAlugCount;