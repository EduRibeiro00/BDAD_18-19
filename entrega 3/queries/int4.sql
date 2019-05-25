.mode columns
.headers on
.nullvalue NULL 

select    idCliente, nome, max(dataAluguer) as alugMaisRecente, idAluguer
from      Aluguer join Pessoa on idPessoa = idCliente
group by  idCliente
having    alugMaisRecente < date('now', '-2 years')  

UNION

select idPessoa as idCliente, nome, NULL, NULL
from   Cliente natural join Pessoa
where  idCliente not in (select idCliente from Aluguer);