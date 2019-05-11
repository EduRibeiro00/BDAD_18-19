.mode columns
.headers on
.nullvalue NULL 

create view auxViewPessoa as 
        select idPessoa as idCliente, nome 
        from Pessoa;

select    idCliente, nome, max(dataAluguer) as alugMaisRecente, idAluguer
from      Aluguer natural join auxViewPessoa
group by  idCliente
having    alugMaisRecente < date('now', '-2 years')  

UNION

select idPessoa as idCliente, nome, NULL, NULL
from   Cliente natural join Pessoa
where  idCliente not in (select idCliente from Aluguer); 

drop view auxViewPessoa;