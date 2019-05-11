.mode columns
.headers on
.nullvalue NULL 

create view auxViewHorarioFunc as
    select idFuncionario as idPessoa, idHorario
    from HorarioFunc;

-- FALTA TRATAR DO FACTO QUE DA RESET QUANDO E MAIS DE 24H

select idPessoa, nome, salario, time(sum(abs(strftime('%s', horaFim) - strftime('%s', horaInicio))), 'unixepoch') as numHoras
from   Funcionario natural join auxViewHorarioFunc natural join Horario natural join Pessoa
group by idPessoa;

drop view auxViewHorarioFunc;