--
-- File generated with SQLiteStudio v3.2.1 on sex abr 5 15:57:30 2019
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: AlugFilme
DROP TABLE IF EXISTS AlugFilme;

CREATE TABLE AlugFilme (
    idAluguer INTEGER CONSTRAINT fk_alugfilme_idaluguer REFERENCES Aluguer (idAluguer),
    idFilme   INTEGER CONSTRAINT fk_alugfilme_idfilme REFERENCES Filme,
    PRIMARY KEY (
        idAluguer,
        idFilme
    )
);


-- Table: Aluguer
DROP TABLE IF EXISTS Aluguer;

CREATE TABLE Aluguer (
    idAluguer    INTEGER PRIMARY KEY,
    dataAluguer  DATE    CONSTRAINT nn_alugues_dataaluguer NOT NULL,
    precoAluguer REAL,
    idLoja       INTEGER CONSTRAINT fk_aluguer_idloja REFERENCES Loja (idLoja),
    idCliente    INTEGER CONSTRAINT fk_aluguer_idcliente REFERENCES Cliente (idPessoa) 
);


-- Table: AluguerAtual
DROP TABLE IF EXISTS AluguerAtual;

CREATE TABLE AluguerAtual (
    idAluguer  INTEGER PRIMARY KEY
                       CONSTRAINT fk_alugueratual_idaluguer REFERENCES Aluguer (idAluguer),
    dataLimite DATE    CONSTRAINT nn_alugueratual_datalimite NOT NULL
);


-- Table: AluguerPassado
DROP TABLE IF EXISTS AluguerPassado;

CREATE TABLE AluguerPassado (
    idAluguer   INTEGER PRIMARY KEY
                        CONSTRAINT fk_aluguerpassado_idaluguer REFERENCES Aluguer (idAluguer),
    dataLimite  DATE    CONSTRAINT nn_aluguerpassado_datalimite NOT NULL,
    dataEntrega DATE    CONSTRAINT nn_aluguerpassado_dataentrega NOT NULL,
    CONSTRAINT check_aluguerpassado_datas CHECK (dataLimite >= dataEntrega) 
);


-- Table: Cliente
DROP TABLE IF EXISTS Cliente;

CREATE TABLE Cliente (
    idPessoa   INTEGER PRIMARY KEY
                       CONSTRAINT fk_cliente_idpessoa REFERENCES Pessoa (idPessoa),
    dataAdesao DATE
);


-- Table: ClienteGold
DROP TABLE IF EXISTS ClienteGold;

CREATE TABLE ClienteGold (
    idCliente      INTEGER PRIMARY KEY
                           CONSTRAINT fk_clientegold_idpessoa REFERENCES Cliente (idPessoa),
    dataSubscricao DATE
);


-- Table: ClienteSilver
DROP TABLE IF EXISTS ClienteSilver;

CREATE TABLE ClienteSilver (
    idCliente      INTEGER PRIMARY KEY
                           CONSTRAINT fk_clientesilver_idcliente REFERENCES Cliente (idPessoa),
    dataSubscricao DATE
);


-- Table: Colecao
DROP TABLE IF EXISTS Colecao;

CREATE TABLE Colecao (
    idColecao    INTEGER PRIMARY KEY,
    nome         TEXT    CONSTRAINT nn_colecao_nome NOT NULL,
    tempoDuracao TEXT,
    numFilmes    INTEGER,
    preco        REAL
);


-- Table: Filme
DROP TABLE IF EXISTS Filme;

CREATE TABLE Filme (
    idFilme       INTEGER  PRIMARY KEY,
    nome          TEXT     CONSTRAINT nn_filme_nome NOT NULL,
    genero        CHAR (1) CONSTRAINT check_filme_genero CHECK (genero = 'ACAO' OR 
                                                                genero = 'COMEDIA' OR 
                                                                genero = 'ROMANCE' OR 
                                                                genero = 'TERROR' OR 
                                                                genero = 'DOCUMENTARIO'),
    duracao       TEXT,
    idioma        TEXT     CONSTRAINT check_filme_idioma CHECK (idioma = 'PT' OR 
                                                                idioma = 'FR' OR 
                                                                idioma = 'EN' OR 
                                                                idioma = 'ES' OR 
                                                                idioma = 'JP'),
    anoLancamento INTEGER,
    preco         REAL     CONSTRAINT nn_filme_preco NOT NULL
                           CONSTRAINT check_filme_preco CHECK (preco > 0),
    idColecao     INTEGER  CONSTRAINT fk_filme_idcolecao REFERENCES Coleção (idColeção) 
);


-- Table: Funcionario
DROP TABLE IF EXISTS Funcionario;

CREATE TABLE Funcionario (
    idPessoa INTEGER PRIMARY KEY
                     CONSTRAINT fk_funcionario_idpessoa REFERENCES Pessoa (idPessoa),
    salario  INTEGER,
    idLoja   INTEGER CONSTRAINT fk_funcionario_idloja REFERENCES Loja (idLoja) 
);


-- Table: Horario
DROP TABLE IF EXISTS Horario;

CREATE TABLE Horario (
    idHorario  INTEGER PRIMARY KEY,
    diaSemana  TEXT    CONSTRAINT check_horario_diasemana CHECK ( (diaSemana = "SEGUNDA-FEIRA" OR 
                                                                   diaSemana = "TERCA-FEIRA" OR 
                                                                   diaSemana = "QUARTA-FEIRA" OR 
                                                                   diaSemana = "QUINTA-FEIRA" OR 
                                                                   diaSemana = "SEXTA-FEIRA" OR 
                                                                   diaSemana = "SABADO" OR 
                                                                   diaSemana = "DOMINGO") ),
    horaInicio TIME,
    horaFim    TIME,
    CONSTRAINT unique_horario_dia_horas UNIQUE (
        diaSemana,
        horaInicio,
        horaFim
    ),
    CONSTRAINT check_horario_horas CHECK (horaFim > horaInicio) 
);


-- Table: HorarioFunc
DROP TABLE IF EXISTS HorarioFunc;

CREATE TABLE HorarioFunc (
    idFuncionario INTEGER CONSTRAINT fk_horariofunc_idfuncionario REFERENCES Funcionario (idPessoa),
    idHorario     INTEGER CONSTRAINT fk_horariofunc_idhorario REFERENCES Horario (idHorario),
    PRIMARY KEY (
        idFuncionario,
        idHorario
    )
);


-- Table: HorarioLoja
DROP TABLE IF EXISTS HorarioLoja;

CREATE TABLE HorarioLoja (
    idLoja    INTEGER CONSTRAINT fk_horarioloja_idloja REFERENCES Loja (idLoja),
    idHorario INTEGER CONSTRAINT fk_horarioloja_idhorario REFERENCES Horario (idHorario),
    PRIMARY KEY (
        idLoja,
        idHorario
    )
);


-- Table: Loja
DROP TABLE IF EXISTS Loja;

CREATE TABLE Loja (
    idLoja    INTEGER PRIMARY KEY,
    local     TEXT    CONSTRAINT unique_loja_local UNIQUE
                      CONSTRAINT nn_loja_local NOT NULL,
    telefone  INTEGER CONSTRAINT unique_loja_telefone UNIQUE,
    idGerente INTEGER CONSTRAINT unique_loja_idgerente UNIQUE
                      CONSTRAINT fk_loja_idgerente REFERENCES Funcionario (idPessoa) 
                      CONSTRAINT nn_loja_idgerente NOT NULL
);


-- Table: Pessoa
DROP TABLE IF EXISTS Pessoa;

CREATE TABLE Pessoa (
    idPessoa       INTEGER PRIMARY KEY,
    nome           TEXT    CONSTRAINT nn_pessoa_nome NOT NULL,
    dataNascimento DATE    CONSTRAINT nn_pessoa_datanascimento NOT NULL,
    morada         TEXT,
    telefone       INTEGER CONSTRAINT nn_pessoa_telefone NOT NULL
);


-- Table: Stock
DROP TABLE IF EXISTS Stock;

CREATE TABLE Stock (
    idLoja        INTEGER CONSTRAINT fk_stock_idloja REFERENCES Loja (idLoja),
    idFilme       INTEGER CONSTRAINT fk_stock_idfilme REFERENCES Filme,
    numExemplares INTEGER CONSTRAINT check_stock_numexemplares CHECK (numExemplares > 0),
    PRIMARY KEY (
        idLoja,
        idFilme
    )
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
