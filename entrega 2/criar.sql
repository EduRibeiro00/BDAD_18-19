--
-- File generated with SQLiteStudio v3.2.1 on dom abr 7 20:26:20 2019
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: AlugFilme
DROP TABLE IF EXISTS AlugFilme;

CREATE TABLE AlugFilme (
    idAluguer INTEGER CONSTRAINT fk_alugfilme_idaluguer REFERENCES Aluguer (idAluguer) ON DELETE CASCADE
                                                                                       ON UPDATE CASCADE,
    idFilme   INTEGER CONSTRAINT fk_alugfilme_idfilme REFERENCES Filme (idFilme) ON DELETE CASCADE
                                                                                 ON UPDATE CASCADE,
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
    idLoja       INTEGER CONSTRAINT fk_aluguer_idloja REFERENCES Loja (idLoja) ON DELETE CASCADE
                                                                               ON UPDATE CASCADE,
    idCliente    INTEGER CONSTRAINT fk_aluguer_idcliente REFERENCES Cliente (idPessoa) ON DELETE CASCADE
                                                                                       ON UPDATE CASCADE,
    dataLimite   DATE    CONSTRAINT nn_aluguer_datalimite NOT NULL,
    dataEntrega  DATE,
    CONSTRAINT check_aluguer_datas CHECK ( ( (dataLimite >= dataEntrega AND 
                                              dataEntrega >= dataAluguer AND 
                                              dataLimite >= dataAluguer) OR 
                                             (dataLimite >= dataAluguer AND 
                                              dataEntrega IS NULL) ) ) 
);


-- Table: Cliente
DROP TABLE IF EXISTS Cliente;

CREATE TABLE Cliente (
    idPessoa   INTEGER PRIMARY KEY
                       CONSTRAINT fk_cliente_idpessoa REFERENCES Pessoa (idPessoa) ON DELETE CASCADE
                                                                                   ON UPDATE CASCADE,
    dataAdesao DATE    CONSTRAINT nn_cliente_dataadesao NOT NULL
);


-- Table: ClienteGold
DROP TABLE IF EXISTS ClienteGold;

CREATE TABLE ClienteGold (
    idCliente      INTEGER PRIMARY KEY
                           CONSTRAINT fk_clientegold_idpessoa REFERENCES Cliente (idPessoa) ON DELETE CASCADE
                                                                                            ON UPDATE CASCADE,
    dataSubscricao DATE    CONSTRAINT nn_clientegold_datasubscricao NOT NULL
);


-- Table: ClienteSilver
DROP TABLE IF EXISTS ClienteSilver;

CREATE TABLE ClienteSilver (
    idCliente      INTEGER PRIMARY KEY
                           CONSTRAINT fk_clientesilver_idcliente REFERENCES Cliente (idPessoa) ON DELETE CASCADE
                                                                                               ON UPDATE CASCADE,
    dataSubscricao DATE    CONSTRAINT nn_clientesilver_datasubscricao NOT NULL
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
    idFilme       INTEGER PRIMARY KEY,
    nome          TEXT    CONSTRAINT nn_filme_nome NOT NULL,
    genero        TEXT    CONSTRAINT check_filme_genero CHECK (genero = 'ACAO' OR 
                                                               genero = 'COMEDIA' OR 
                                                               genero = 'ROMANCE' OR 
                                                               genero = 'TERROR' OR 
                                                               genero = 'DOCUMENTARIO' OR 
                                                               genero = 'FANTASIA' OR 
                                                               genero = 'DRAMA'),
    duracao       INTEGER,
    idioma        TEXT    CONSTRAINT check_filme_idioma CHECK (idioma = 'PT' OR 
                                                               idioma = 'FR' OR 
                                                               idioma = 'EN' OR 
                                                               idioma = 'ES' OR 
                                                               idioma = 'JP'),
    anoLancamento INTEGER,
    preco         REAL    CONSTRAINT nn_filme_preco NOT NULL
                          CONSTRAINT check_filme_preco CHECK (preco > 0),
    idColecao     INTEGER CONSTRAINT fk_filme_idcolecao REFERENCES Colecao (idColecao) ON DELETE SET NULL
                                                                                       ON UPDATE CASCADE
);


-- Table: Funcionario
DROP TABLE IF EXISTS Funcionario;

CREATE TABLE Funcionario (
    idPessoa        INTEGER PRIMARY KEY
                            CONSTRAINT fk_funcionario_idpessoa REFERENCES Pessoa (idPessoa) ON DELETE CASCADE
                                                                                            ON UPDATE CASCADE,
    salario         INTEGER CONSTRAINT nn_funcionario_salario NOT NULL,
    idLoja          INTEGER CONSTRAINT fk_funcionario_idloja REFERENCES Loja (idLoja) ON DELETE SET NULL
                                                                                      ON UPDATE CASCADE,
    dataContratacao DATE    CONSTRAINT nn_funcionario_datacontratacao NOT NULL
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
    idFuncionario INTEGER CONSTRAINT fk_horariofunc_idfuncionario REFERENCES Funcionario (idPessoa) ON DELETE CASCADE
                                                                                                    ON UPDATE CASCADE,
    idHorario     INTEGER CONSTRAINT fk_horariofunc_idhorario REFERENCES Horario (idHorario) ON DELETE CASCADE
                                                                                             ON UPDATE CASCADE,
    PRIMARY KEY (
        idFuncionario,
        idHorario
    )
);


-- Table: HorarioLoja
DROP TABLE IF EXISTS HorarioLoja;

CREATE TABLE HorarioLoja (
    idLoja    INTEGER CONSTRAINT fk_horarioloja_idloja REFERENCES Loja (idLoja) ON DELETE CASCADE
                                                                                ON UPDATE CASCADE,
    idHorario INTEGER CONSTRAINT fk_horarioloja_idhorario REFERENCES Horario (idHorario) ON DELETE CASCADE
                                                                                         ON UPDATE CASCADE,
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
                      CONSTRAINT fk_loja_idgerente REFERENCES Funcionario (idPessoa) ON DELETE RESTRICT
                                                                                     ON UPDATE CASCADE
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
    idLoja        INTEGER CONSTRAINT fk_stock_idloja REFERENCES Loja (idLoja) ON DELETE CASCADE
                                                                              ON UPDATE CASCADE,
    idFilme       INTEGER CONSTRAINT fk_stock_idfilme REFERENCES Filme (idFilme) ON DELETE CASCADE
                                                                                 ON UPDATE CASCADE,
    numExemplares INTEGER CONSTRAINT check_stock_numexemplares CHECK (numExemplares > 0),
    PRIMARY KEY (
        idLoja,
        idFilme
    )
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
