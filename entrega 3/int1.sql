.mode columns
.headers on
.nullvalue NULL 

select idFilme, nome, numExemplares, idLoja, local
from   Filme natural join Stock natural join Loja
where numExemplares <= 2

UNION

select idFilme, nome, 0 as numExemplares, idLoja, local
from   Filme, Loja
where  not exists (select idFilme
                   from Stock
                   where Filme.idFilme = Stock.idFilme and 
                         Loja.idLoja = Stock.idLoja)
                         
order by idLoja, numExemplares;