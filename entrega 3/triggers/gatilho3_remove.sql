.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS InsertIdadeValida;
DROP TRIGGER IF EXISTS UpdateIdadeValida;