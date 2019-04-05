--
-- File generated with SQLiteStudio v3.2.1 on qua abr 3 17:51:25 2019
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = on;
BEGIN TRANSACTION;

-- Table: AlugFilme
DROP TABLE IF EXISTS AlugFilme;
CREATE TABLE AlugFilme (idAluguer INTEGER, idFilme INTEGER, PRIMARY KEY (idAluguer, idFilme));

-- Table: Aluguer
DROP TABLE IF EXISTS Aluguer;
CREATE TABLE Aluguer (idAluguer INTEGER PRIMARY KEY, dataAluguer DATETIME, preçoAluguer REAL, idLoja INTEGER, idCliente INTEGER);

-- Table: AluguerAtual
DROP TABLE IF EXISTS AluguerAtual;
CREATE TABLE AluguerAtual (idAluguer INTEGER PRIMARY KEY, dataLimite DATE);

-- Table: AluguerPassado
DROP TABLE IF EXISTS AluguerPassado;
CREATE TABLE AluguerPassado (idAluguer INTEGER PRIMARY KEY, dataLimite DATE, dataEntrega DATE);

-- Table: Cliente
DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (idPessoa INTEGER PRIMARY KEY, dataAdesão DATE);

-- Table: ClienteGold
DROP TABLE IF EXISTS ClienteGold;
CREATE TABLE ClienteGold (idCliente INTEGER PRIMARY KEY, dataSubscrição DATE);

-- Table: ClienteSilver
DROP TABLE IF EXISTS ClienteSilver;
CREATE TABLE ClienteSilver (idCliente INTEGER PRIMARY KEY, dataSubscrição DATE);

-- Table: Coleção
DROP TABLE IF EXISTS Coleção;
CREATE TABLE Coleção (idColeção INTEGER PRIMARY KEY, nome TEXT, tempoDuração TEXT, numFilmes INTEGER, preço REAL);

-- Table: Filme
DROP TABLE IF EXISTS Filme;
CREATE TABLE Filme (idFilme INTEGER PRIMARY KEY, nome TEXT, género CHAR (1), duração TEXT, idioma TEXT, anoLançamento INTEGER, preço REAL, idColeção INTEGER);

-- Table: Funcionário
DROP TABLE IF EXISTS Funcionário;
CREATE TABLE Funcionário (idPessoa INTEGER PRIMARY KEY, salário INTEGER, idLoja INTEGER);

-- Table: Horário
DROP TABLE IF EXISTS Horário;
CREATE TABLE Horário (idHorário INTEGER PRIMARY KEY, diaSemana TEXT, horaInicio TEXT, horaFim TEXT);

-- Table: HorárioFunc
DROP TABLE IF EXISTS HorárioFunc;
CREATE TABLE HorárioFunc (idFuncionário INTEGER, idHorário INTEGER, PRIMARY KEY (idFuncionário, idHorário));

-- Table: HorárioLoja
DROP TABLE IF EXISTS HorárioLoja;
CREATE TABLE HorárioLoja (idLoja INTEGER, idHorário INTEGER, PRIMARY KEY (idLoja, idHorário));

-- Table: Loja
DROP TABLE IF EXISTS Loja;
CREATE TABLE Loja (idLoja INTEGER PRIMARY KEY, local TEXT UNIQUE, telefone INTEGER UNIQUE, idGerente INTEGER UNIQUE);

-- Table: Pessoa
DROP TABLE IF EXISTS Pessoa;
CREATE TABLE Pessoa (idPessoa INTEGER PRIMARY KEY, nome TEXT, dataNascimento DATE, morada TEXT, telefone INTEGER);

-- Table: Stock
DROP TABLE IF EXISTS Stock;
CREATE TABLE Stock (idLoja INTEGER, idFilme INTEGER, numExemplares INTEGER, PRIMARY KEY (idLoja, idFilme));

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
