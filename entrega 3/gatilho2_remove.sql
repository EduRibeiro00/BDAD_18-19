.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS adicionaPrecoAluguer;
DROP TRIGGER IF EXISTS retiraPrecoAluguer;