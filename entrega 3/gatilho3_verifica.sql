.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Estado atual dos funcionarios:'
.print ''

SELECT idPessoa, salario, dataContratacao, dataNascimento from Funcionario natural join Pessoa;

INSERT INTO Pessoa values (99999, 'Ricardo Guimaraes', '2019-01-01', 'Berco da Naçao', 912345678);
INSERT INTO Pessoa values (90009, 'Jose Portugal', '1143-10-05', 'Peninsula Iberica', 987654321);

.print ''
.print 'Pessoa com idade inferior a 16 anos (data de nascimento em 2019):'
.print ''

SELECT * from Pessoa WHERE Pessoa.idPessoa = 99999; 

.print ''
.print 'Tentando torna-lo funcionario...'
.print ''

INSERT INTO Funcionario values (99999, 700, 'now');

.print ''
.print ''

.print ''
.print 'Estado atual dos funcionarios (como se pode observar, ele nao foi introduzido):'
.print ''

SELECT idPessoa, salario, dataContratacao, dataNascimento from Funcionario natural join Pessoa;

.print ''
.print 'Pessoa com idade válida:'
.print ''

SELECT * from Pessoa WHERE Pessoa.idPessoa = 90009; 

.print ''
.print 'Tentando torna-lo funcionario...'
.print ''

INSERT INTO Funcionario values (90009, 700, 'now');

.print ''
.print 'Estado atual dos clientes (como se pode observar, este esta presente na tabela dos funcionarios):'
.print ''

SELECT idPessoa, salario, dataContratacao, dataNascimento from Funcionario natural join Pessoa;


.print ''
.print 'Tentando atualizar a data de nascimento do funcionario 90009 para 2000-04-04:'
.print ''

UPDATE Pessoa
SET dataNascimento = '2000-04-04'
WHERE idPessoa = 90009;

.print ''
.print 'Estado atual dos funcionarios:'
.print ''

SELECT idPessoa, salario, dataContratacao, dataNascimento from Funcionario natural join Pessoa;

.print ''
.print 'Tentando atualizar a data de nascimento do funcionario 90009 para 2017-04-04:'
.print ''

UPDATE Pessoa
SET dataNascimento = '2017-04-04'
WHERE idPessoa = 90009;

.print ''
.print 'Estado atual dos funcionarios:'
.print ''

SELECT idPessoa, salario, dataContratacao, dataNascimento from Funcionario natural join Pessoa;
