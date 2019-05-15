.mode columns
.headers on
.nullvalue NULL

select idCliente, nome, count(*) as numFilmes, sum(preco) as precoTotal
from Aluguer natural join (select Cliente.idPessoa as idCliente, nome
                           from Pessoa join Cliente
                           on Pessoa.idPessoa = Cliente.idPessoa)
             natural join (select idAluguer, Filme.idFilme, preco
                           from AlugFilme join Filme
                           on AlugFilme.idFilme = Filme.idFilme)
where dataEntrega is null
group by idCliente;
