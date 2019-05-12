.mode columns
.headers on
.nullvalue NULL

select idFilme, nome, genero, preco, count(*) as numAlugs
from   Filme join AlugFilme using(idFilme)
group by idFilme

UNION

select idFilme, nome, genero, preco, 0
from   Filme
where  idFilme not in (select idFilme from AlugFilme)

order by numAlugs DESC, preco DESC;