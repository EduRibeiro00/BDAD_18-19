.mode columns
.headers on
.nullvalue NULL


select diaSemana, count(distinct idLoja) as numLojas
from Horario natural join HorarioLoja
group by diaSemana;