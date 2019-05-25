.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Estado atual dos clientes:'
.print ''

SELECT * from Cliente;

INSERT INTO Pessoa values (99999, 'Ricardo Guimaraes', '2019-01-01', 'Berco da Naçao', 912345678);
INSERT INTO Pessoa values (90009, 'Jose Portugal', '1143-10-05', 'Peninsula Iberica', 987654321);

.print ''
.print 'Pessoa com idade inferior a 10 anos (data de nascimento em 2019):'
.print ''

SELECT * from Pessoa WHERE Pessoa.idPessoa = 99999; 

.print ''
.print 'Tentando torna-lo cliente...'
.print ''

INSERT INTO Cliente values (99999, 'now');

.print ''
.print ''

.print ''
.print 'Estado atual dos clientes (como se pode observar, ele nao foi introduzido):'
.print ''

SELECT * from Cliente;

.print ''
.print 'Pessoa com idade válida:'
.print ''

SELECT * from Pessoa WHERE Pessoa.idPessoa = 90009; 

.print ''
.print 'Tentando torna-lo cliente...'
.print ''

INSERT INTO Cliente values (90009, 'now');

.print ''

.print ''
.print 'Estado atual dos clientes (como se pode observar, este esta presente na tabela dos clientes):'
.print ''

SELECT * from Cliente;
