.mode columns
.headers on
.nullvalue NULL

create view auxViewFuncionario as
    select idPessoa as idFuncionario, salario
    from Funcionario;


select idLoja, local, avg(salario) as mediaSalario
from Loja natural join LojaFuncionario natural join auxViewFuncionario
group by idLoja;

drop view auxViewFuncionario;