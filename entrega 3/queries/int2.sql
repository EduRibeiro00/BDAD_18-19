.mode columns
.headers on
.nullvalue NULL 

-- NOTA: nao foi usada a funcao strftime() uma vez que esta impoe um limite de 24 no campo das horas,
--       e ha funcionarios que trabalham mais de 24 horas por semana. 

select idPessoa, nome, salario, (sum(abs(strftime('%s', horaFim) - strftime('%s', horaInicio)))) / 3600 as numHoras
from   (Funcionario join HorarioFunc on idPessoa = idFuncionario) natural join Horario natural join Pessoa
group by idPessoa
order by numHoras DESC;
