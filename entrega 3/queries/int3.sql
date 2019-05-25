.mode columns
.headers on
.nullvalue NULL

select idPessoa as idCliente, Pessoa.nome, count(*) as numFilmes, sum(preco) as precoTotal
from ((Pessoa join Aluguer on idCliente = idPessoa) natural join AlugFilme) join Filme using (idFilme)
where dataEntrega is null
group by idCliente;