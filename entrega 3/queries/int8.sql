.mode columns
.headers on
.nullvalue NULL

select idLoja, local, avg(salario) as mediaSalario
from (Loja natural join LojaFuncionario) join Funcionario on idPessoa = idFuncionario
group by idLoja;