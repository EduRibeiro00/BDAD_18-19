.mode columns
.headers on
.nullvalue NULL

select idLoja, local, strftime('%Y-%m', dataAluguer) as mes, sum(precoAluguer) as lucro
from Loja JOIN Aluguer using(idLoja)
group by idLoja, mes
order by idLoja, mes DESC;
